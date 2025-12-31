# Piper TTS Snap

A snap package for [Piper](https://github.com/rhasspy/piper) - a fast, local neural text-to-speech system.

## Features

- 🚀 **Fast & Local**: No cloud required, runs on your hardware
- 🎯 **High Quality**: Neural TTS with natural-sounding voices
- 🔌 **TCP Server**: Easy integration via network socket
- 📦 **Self-Contained**: Includes Piper binary and default voice model
- 🏠 **Home Assistant Ready**: Perfect for HERMES and other HA integrations
- 🔒 **Confined**: Runs securely with snap confinement

## Installation

### From Snap Store (when published)
```bash
sudo snap install piper-tts
```

### Build from Source
```bash
git clone https://github.com/kenvandine/piper-tts-snap.git
cd piper-tts-snap
snapcraft
sudo snap install --dangerous piper-tts_*.snap
```

## Usage

### As a Service (Daemon)

The snap runs as a background service automatically:

```bash
# Check status
snap services piper-tts

# View logs
snap logs piper-tts -f

# Restart service
sudo snap restart piper-tts
```

The server listens on **port 10200** by default.

### Test the Server

```bash
# Send text and receive audio
echo "Hello from Piper TTS" | nc localhost 10200 > output.wav
aplay output.wav  # or use your audio player
```

### Command Line (CLI)

Convert text to speech directly:

```bash
# Text to file
echo "Hello world" | piper-tts.piper-cli --output_file hello.wav

# From stdin
piper-tts.piper-cli --output_file output.wav < input.txt

# JSON output
echo "Hello" | piper-tts.piper-cli --output_file /dev/stdout --json-input
```

## Configuration

### Change Port

```bash
sudo snap set piper-tts port=10200
sudo snap restart piper-tts
```

### Change Voice Model

```bash
# List available voices
ls /var/snap/piper-tts/common/data/voices/

# Set voice
sudo snap set piper-tts voice=en_US-amy-medium
sudo snap restart piper-tts
```

### Install Additional Voices

Download voice models from [Piper releases](https://github.com/rhasspy/piper/releases):

```bash
# Download and extract voice
cd /var/snap/piper-tts/common/data/voices/
sudo wget https://github.com/rhasspy/piper/releases/download/v1.2.0/voice-en-us-amy-medium.tar.gz
sudo tar -xzf voice-en-us-amy-medium.tar.gz
sudo rm voice-en-us-amy-medium.tar.gz

# Use the new voice
sudo snap set piper-tts voice=en_US-amy-medium
sudo snap restart piper-tts
```

## Integration with HERMES

For the HERMES intercom system:

```cpp
// In include/config.h
#define PIPER_SERVER_URL "http://localhost"
#define PIPER_SERVER_PORT 10200
```

Then connect via HTTP/TCP to localhost:10200 and send text to get audio.

## Integration with Home Assistant

### Wyoming Protocol (Future)

The snap can be extended to support the Wyoming protocol for native Home Assistant integration.

### TCP Server (Current)

Use the TCP server directly:

```yaml
# configuration.yaml
shell_command:
  speak_text: 'echo "{{ text }}" | nc localhost 10200 > /tmp/speech.wav && aplay /tmp/speech.wav'

# automation
automation:
  - alias: "Announce doorbell"
    trigger:
      platform: state
      entity_id: binary_sensor.doorbell
      to: 'on'
    action:
      service: shell_command.speak_text
      data:
        text: "Someone is at the door"
```

## Architecture Support

- ✅ AMD64 (x86_64)
- ✅ ARM64 (aarch64) - Raspberry Pi 4, etc.
- ✅ ARMhf (armv7l) - Raspberry Pi 3, etc.

## Available Voices

Default voice included: **en_US-lessac-medium**

Additional voices available from [Piper releases](https://github.com/rhasspy/piper/releases/tag/v1.2.0):
- en_US-amy-medium
- en_US-ryan-high
- en_GB-alan-medium
- de_DE-thorsten-medium
- es_ES-sharvard-medium
- fr_FR-siwis-medium
- And many more!

## Performance

Tested on Raspberry Pi 4:
- Synthesis: ~95% realtime
- Latency: <500ms for short phrases
- Memory: ~200MB

On x86_64:
- Synthesis: Real-time or faster
- Latency: <200ms
- Memory: ~150MB

## Troubleshooting

### Service won't start

Check logs:
```bash
snap logs piper-tts -f
```

### Permission denied

The snap is strictly confined. Ensure you're using the proper interface:
```bash
snap connections piper-tts
```

### Voice model not found

Verify voice files:
```bash
ls -la /var/snap/piper-tts/common/data/voices/
```

## Development

### Build the snap

```bash
snapcraft clean
snapcraft
```

### Test locally

```bash
sudo snap install --dangerous piper-tts_*.snap
snap logs piper-tts -f
```

### Debug mode

```bash
sudo snap set piper-tts debug=true
sudo snap restart piper-tts
```

## License

This snap package: MIT License

Piper TTS: MIT License - see https://github.com/rhasspy/piper

## Credits

- **Piper TTS** by Rhasspy: https://github.com/rhasspy/piper
- **HERMES** integration: https://github.com/kenvandine/hermes
- Snap package by: Ken VanDine

## Links

- **Piper GitHub**: https://github.com/rhasspy/piper
- **Piper Samples**: https://rhasspy.github.io/piper-samples/
- **Voice Downloads**: https://github.com/rhasspy/piper/releases
- **HERMES Project**: https://github.com/kenvandine/hermes

---

**Piper TTS Snap** - Fast, local text-to-speech for your projects 🎤
