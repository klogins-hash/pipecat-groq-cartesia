# Pipecat Quickstart

Build and deploy your first voice AI bot in under 10 minutes. Develop locally, then scale to production on Pipecat Cloud.

**Two steps**: [🏠 Local Development](#run-your-bot-locally) → [☁️ Production Deployment](#deploy-to-production)

## Step 1: Local Development (5 min)

### Prerequisites

#### Environment

- Python 3.10 or later
- [uv](https://docs.astral.sh/uv/getting-started/installation/) package manager installed

#### AI Service API keys
You'll need API keys from two services:

- [Groq](https://console.groq.com/) for ultra-fast LLM inference
- [Cartesia](https://play.cartesia.ai/sign-up) for Speech-to-Text and Text-to-Speech

> 💡 **Tip**: Sign up for both services now. You'll need them for both local and cloud deployment.

Your setup follows the exact same architecture as the official quickstart but with **premium services** (Groq + Cartesia). Everything should work perfectly:

1. Clone this repository

   ```bash
   git clone https://github.com/pipecat-ai/pipecat-quickstart.git
{{ ... }}
   ```

2. Configure your API keys:

   Create a `.env` file:

   ```bash
   cp env.example .env
   ```

   Then, add your API keys:

   ```ini
   GROQ_API_KEY=your_groq_api_key
   CARTESIA_API_KEY=your_cartesia_api_key
   ```

3. Set up a virtual environment and install dependencies

   ```bash
   uv sync
   ```

### Run your bot locally

```bash
uv run bot.py
```

**Open http://localhost:7860 in your browser** and click `Connect` to start talking to your bot.

> 💡 First run note: The initial startup may take ~20 seconds as Pipecat downloads required models and imports.

🎉 **Success!** Your bot is running locally. Now let's deploy it to production so others can use it.

---

## Step 2: Deploy to Production (5 min)

Transform your local bot into a production-ready service. Pipecat Cloud handles scaling, monitoring, and global deployment.

### Prerequisites

1. [Sign up for Pipecat Cloud](https://pipecat.daily.co/sign-up).

2. Set up Docker for building your bot image:

   - **Install [Docker](https://www.docker.com/)** on your system
   - **Create a [Docker Hub](https://hub.docker.com/) account**
   - **Login to Docker Hub:**

     ```bash
     docker login
     ```

3. Log in with the `pipecatcloud` CLI—installed with the quickstart project—is used to manage your deployment and secrets.

   ```bash
   uv run pcc auth login
   ```

   > Tip: Use the CLI with the `pcc` command alias.

### Configure your deployment

The `pcc-deploy.toml` file tells Pipecat Cloud how to run your bot. **Update the image field** with your Docker Hub username by editing `pcc-deploy.toml`.

```ini
agent_name = "quickstart"
image = "YOUR_DOCKERHUB_USERNAME/quickstart:0.1"  # 👈 Update this line
secret_set = "quickstart-secrets"

[scaling]
	min_agents = 1
```

**Understanding the TOML file settings:**

- `agent_name`: Your bot's name in Pipecat Cloud
- `image`: The Docker image to deploy (format: `username/image:version`)
- `secret_set`: Where your API keys are stored securely
- `min_agents`: Number of bot instances to keep ready (1 = instant start)

> 💡 Tip: [Set up `image_credentials`](https://docs.pipecat.ai/deployment/pipecat-cloud/fundamentals/secrets#image-pull-secrets) in your TOML file for authenticated image pulls

### Configure secrets

Upload your API keys to Pipecat Cloud's secure storage:

```bash
uv run pcc secrets set quickstart-secrets --file .env
```

This creates a secret set called `quickstart-secrets` (matching your TOML file) and uploads all your API keys from `.env`.

### Build and deploy

Build your Docker image and push to Docker Hub:

```bash
uv run pcc docker build-push
```

Deploy to Pipecat Cloud:

```bash
uv run pcc deploy
```

### Connect to your agent

1. Open your [Pipecat Cloud dashboard](https://pipecat.daily.co/)
2. Select your `quickstart` agent → **Sandbox**
3. Allow microphone access and click **Connect**

---

## What's Next?

**🔧 Customize your bot**: Modify `bot.py` to change personality, add functions, or integrate with your data  
**📚 Learn more**: Check out [Pipecat's docs](https://docs.pipecat.ai/) for advanced features  
**💬 Get help**: Join [Pipecat's Discord](https://discord.gg/pipecat) to connect with the community

### Troubleshooting

- **Browser permissions**: Allow microphone access when prompted
- **Connection issues**: Try a different browser or check VPN/firewall settings
- **Audio issues**: Verify microphone and speakers are working and not muted
