package main

import (
	"errors"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/gofiber/fiber/v2/middleware/favicon"
	"github.com/gofiber/fiber/v2/middleware/logger"
	"github.com/gofiber/template/html"

	"github.com/dgrijalva/jwt-go"
	"github.com/gofiber/fiber/v2"
)

var secret = []byte("ca4d39ca3f06692202f66f5b2e7cb437060011c74e174a7620ad180d2c3f1ad5")

type JWTClaims struct {
	Name       string `json:"name"`
	FlagViewer bool   `json:"flag_viewer"`
	jwt.StandardClaims
}

type AuthenticationError struct {
	Err error
}

func (e *AuthenticationError) Error() string {
	return fmt.Sprintf("Authentication Failure")
}

func validateJWT(userJWT string) (JWTClaims, error) {
	token, err := jwt.ParseWithClaims(userJWT, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
		}
		return secret, nil
	})
	if err != nil {
		log.Printf("Error in parsing JWT: %s", err)
		return JWTClaims{}, errors.New("error in parsing JWT")
	}

	claims := token.Claims.(*JWTClaims)

	return *claims, nil
}

func GenerateJWT(username string, password string) (string, error) {
	real_username := "pope"
	real_password := "papal_passw0rd!"

	if username != real_username || password != real_password {
		return "", &AuthenticationError{}
	}

	expirationTime := time.Now().Add(2 * time.Hour)
	claims := JWTClaims{
		"pope",
		false,
		jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
			Issuer:    "The Holy See",
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	ss, err := token.SignedString(secret)
	if err != nil {
		return "", errors.New("Unable to sign JWT")
	}
	return ss, nil
}

func index(c *fiber.Ctx) error {
	return c.Render("index", fiber.Map{})
}

func loginGET(c *fiber.Ctx) error {
	return c.Render("login", fiber.Map{})
}

func loginPOST(c *fiber.Ctx) error {
	userJWT, err := GenerateJWT(c.FormValue("username"), c.FormValue("password"))
	if err != nil {
		if err == err.(*AuthenticationError) {
			c.Status(400)
			return c.SendString("Authentication Error.")
		}
		c.Status(400)
		return c.SendString("Improper Input. Are you trying to hack me?")
	}
	sessionCookie := new(fiber.Cookie)
	sessionCookie.Name = "session"
	sessionCookie.Value = userJWT
	sessionCookie.Path = "/"

	c.Cookie(sessionCookie)

	return c.Redirect("/flag")
}

func download(c *fiber.Ctx) error {
	return c.SendFile("./flag-vault-1")
}

func flag(c *fiber.Ctx) error {
	//Check JWT
	var userJWT = c.Cookies("session")
	claims, err := validateJWT(userJWT)
	if userJWT == "" || (err == nil && !claims.FlagViewer) {
		return c.Status(403).SendString("You are not authorized to view the flag")
	}

	if err != nil {
		return c.Status(400).SendString("Your JWT is a little... uh... broken...")
	}

	flag := os.Getenv("FLAG")
	log.Printf("User at IP %s got the flag!", c.IP())
	return c.SendString("Welcome to the system, here's the flag: " + flag + "!")
}

func main() {

	engine := html.New("./views", ".html")
	app := fiber.New(fiber.Config{
		Views:       engine,
		ProxyHeader: "X-Forwarded-For",
	})

	app.Use(logger.New())
	app.Use(favicon.New(favicon.Config{
		File: "./favicon.png",
	}))

	app.Get("/", index)
	app.Get("/login", loginGET)
	app.Post("/login", loginPOST)
	app.Get("/flag", flag)
	app.Get("/download", download)

	log.Fatal(app.Listen(":3000"))
}
