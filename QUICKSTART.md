# Quick Start Guide

## Build the Snap

```bash
cd /home/ken/src/github/kenvandine/piper-tts-snap

# Install snapcraft if needed
sudo snap install snapcraft --classic

# Build the snap
snapcraft

# This will:
# 1. Download Piper binary for your architecture
# 2. Download the default voice model (en_US-lessac-medium)
# 3. Package everything into a .snap file
```

## Install Locally

```bash
# Install the built snap
sudo snap install --dangerous piper-tts_1.2.0_*.snap

# Enable auto-start
sudo snap start piper-tts
```

## Test It

```bash
# Check if service is running
snap services piper-tts

# View logs
snap logs piper-tts -f

# Test the TTS server
echo "Hello from Piper TTS" | nc localhost 10200 > test.wav
aplay test.wav

# Or use command line
echo "Testing one two three" | piper-tts.piper-cli --output_file test2.wav
aplay test2.wav
```

## Configure

```bash
# Change port (default: 10200)
sudo snap set piper-tts port=10200

# Change voice (default: en_US-lessac-medium)
sudo snap set piper-tts voice=en_US-amy-medium

# Restart after config changes
sudo snap restart piper-tts
```

## Add More Voices

```bash
# Download additional voice (from Hugging Face)
cd /var/snap/piper-tts/common/data/voices/
sudo wget 'https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/amy/medium/en_US-amy-medium.onnx?download=true' -O en_US-amy-medium.onnx
sudo wget 'https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/amy/medium/en_US-amy-medium.onnx.json?download=true' -O en_US-amy-medium.onnx.json

# Use the new voice
sudo snap set piper-tts voice=en_US-amy-medium
sudo snap restart piper-tts
```

## Integration with HERMES

1. Install this snap on your server
2. Configure HERMES to use it:

```cpp
// include/config.h in HERMES project
#define PIPER_SERVER_URL "http://your-server-ip"
#define PIPER_SERVER_PORT 10200
```

3. Test from HERMES device:
```bash
echo "Hello from HERMES" | nc your-server-ip 10200 > test.wav
```

## Troubleshooting

### Port already in use
```bash
# Check what's using port 10200
sudo lsof -i :10200

# Change to different port
sudo snap set piper-tts port=10201
sudo snap restart piper-tts
```

### Voice model missing
```bash
# List available voices
ls -la /var/snap/piper-tts/common/data/voices/

# Re-install default voice
sudo snap remove piper-tts
sudo snap install --dangerous piper-tts_*.snap
```

### Service won't start
```bash
# Check logs for errors
snap logs piper-tts

# Check permissions
snap connections piper-tts

# Restart service
sudo snap restart piper-tts
```

## Next Steps

- [ ] Build and test the snap
- [ ] Test with HERMES integration
- [ ] Add more voice models
- [ ] Publish to Snap Store (optional)
- [ ] Set up on production server

## File Structure

```
piper-tts-snap/
├── snapcraft.yaml              # Snap build configuration
├── snap/
│   └── local/
│       ├── piper-launcher      # Server daemon script
│       └── piper-wrapper       # CLI wrapper script
├── README.md                   # Full documentation
├── QUICKSTART.md              # This file
├── LICENSE                     # MIT License
└── .gitignore                 # Git ignore rules
```

## Building for Different Architectures

```bash
# Build for specific architecture
snapcraft --target-arch=amd64
snapcraft --target-arch=arm64
snapcraft --target-arch=armhf

# Or use remote build (requires Launchpad account)
snapcraft remote-build
```

---

**Ready to build!** Run `snapcraft` to create your Piper TTS snap package. 🎤
