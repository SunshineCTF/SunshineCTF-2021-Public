# Handout-only challenge: no build or server, just publish the files players
# download (served from publish/ at /files/...)
PUBLISH := attachments/encrypt_wav.py

# flag_encrypted.wav (3 MB) is kept xz-compressed in git; publishing
# decompresses it so players download the .wav itself (the web server
# compresses in transit).
$(BUILD_DIR)/flag_encrypted.wav: $(DIR)/attachments/flag_encrypted.wav.xz
	$(_V)echo "Unpacking $(@F)"
	$(_v)mkdir -p $(@D) && xz -dc $< > $@

PUBLISH_BUILD := flag_encrypted.wav
