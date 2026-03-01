🚀 Multi-Stage Key Generator Experiment

🎯 Objective

Conduct a controlled Docker experiment to demonstrate:
	•	The difference between a fat image and a multi-stage slim image
	•	How Docker layers work
	•	How build dependencies affect image size
	•	Why multi-stage reduces attack surface
	•	Proper CLI container design (ENTRYPOINT vs CMD)

⸻
## 📁 Project Structure

```
multistage_keygen/
├── app/
│   ├── main.py
│   └── generator.py
├── requirements.txt
├── Dockerfile.fat
├── Dockerfile.slim
└── README.md
```
⸻

🧠 Application Overview

A CLI utility that:
	•	Generates cryptographically secure random keys
	•	Supports:
	•	hex
	•	base64
	•	urlsafe
	•	Accepts length in bytes
	•	Can optionally save output to file

Example:

docker run --rm keygen-slim --length 32 --format hex


⸻

🧱 Phase 1 — FAT Image

Configuration
	•	Base: python:3.12
	•	Installed:
	•	build-essential
	•	libssl-dev
	•	libffi-dev
	•	Installed dependency:
	•	cryptography
	•	No apt cache cleanup
	•	No multi-stage

Result

Metric	Value
Image size	1.16 GB
Build time	~3–4 minutes
Build tools present	Yes
apt cache present	Yes

docker images

REPOSITORY   TAG       SIZE
keygen-fat   latest    1.16GB

Observations
	•	Large base image
	•	Build tools included in runtime
	•	Dev libraries increase attack surface
	•	Slow image pull in production

⸻

🧱 Phase 2 — Multi-Stage Image

Architecture

Builder stage
	•	Installs build dependencies
	•	Installs Python packages
	•	Compiles cryptography if needed

Runtime stage
	•	Based on python:3.12-slim
	•	Copies only:
	•	/usr/local/lib/python3.12/site-packages
	•	/app
	•	No build tools
	•	ENTRYPOINT used instead of CMD

⸻

📊 Comparison

Metric	Fat	Slim
Image size	1.16 GB	144 MB
Layers	Multiple heavy apt layers	Minimal
Build tools in runtime	Yes	No
Attack surface	High	Reduced
Pull speed	Slow	Fast

Size reduction: ~88%

⸻

🔐 Why Multi-Stage Works

Multi-stage builds:
	•	Separate build environment from runtime
	•	Remove compilers and dev headers from final image
	•	Reduce image size dramatically
	•	Improve deployment speed
	•	Lower attack surface

Only compiled artifacts (.so files) and application code are copied into runtime.

⸻

⚙ ENTRYPOINT vs CMD

Using:

ENTRYPOINT ["python", "main.py"]

Allows passing CLI arguments cleanly:

docker run --rm keygen-slim --length 32 --format base64

If CMD were used, Docker would replace the command when arguments are passed.

⸻

📦 Layer Caching Strategy

Correct order:

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

Why?
	•	Code changes do not invalidate dependency layer
	•	Faster rebuilds
	•	Efficient CI/CD behavior

⸻

🧪 Usage Examples

Generate 256-bit hex key:

docker run --rm keygen-slim --length 32 --format hex

Generate URL-safe key:

docker run --rm keygen-slim --length 32 --format urlsafe

Save to file:

docker run --rm -v $(pwd):/app keygen-slim \
  --length 32 --format hex --output key.txt


⸻

🎓 Lessons Learned
	•	Docker layers depend on instruction order
	•	Multi-stage isolates build dependencies
	•	ENTRYPOINT is better for CLI containers
	•	Absolute paths prevent unpredictable behavior
	•	Relative WORKDIR is unsafe
	•	Fat images significantly increase deployment time
	•	Image size directly impacts Kubernetes scaling performance

⸻

🚀 Production Insight

Multi-stage builds are not just about image size.

They improve:
	•	Deployment speed
	•	CI/CD efficiency
	•	Security posture
	•	Infrastructure reliability

⸻

📌 Conclusion

This experiment demonstrates how build architecture decisions affect:
	•	Image size
	•	Security
	•	Deployment performance
	•	Runtime cleanliness

Multi-stage builds are a production-grade standard for containerized applications.

⸻

📎 Next Steps
	•	Add non-root runtime user
	•	Add healthcheck
	•	Push image to registry
	•	Automate build via CI

