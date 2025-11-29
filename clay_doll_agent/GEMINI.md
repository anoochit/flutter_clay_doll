# Gemini Project Configuration

## Project Title

Clay Doll Agent

## Project Goal

To develop a FastAPI application that serves an agent capable of generating images of clay dolls based on user descriptions.

## Key Files

- `main.py`: The main FastAPI application file that serves the agent.
- `clay_doll_generator/agent.py`: The configuration file for the `root_agent`, including its model, description, and instructions.
- `pyproject.toml`: The project's dependencies, including `google-adk`.

## Core Technologies

- Python
- FastAPI
- `google-adk`

## Development Workflow

- **Running the Application**: The application can be run using the command `python main.py`. This will start a `uvicorn` server.
- **Updating the Agent**: To update the agent, modify the `root_agent` definition in `clay_doll_generator/agent.py`.

## Agent Configuration

- **Model**: `gemini-3-pro-preview`
- **Description**: `An assistant that generates high-quality images of clay dolls based on user prompts.`
- **Instruction**: `Generate a high-quality image of a clay doll based on the user's description. The image should have a 1:1 aspect ratio and a small file size, suitable for web use. The doll should be the main subject of the image, with a simple background.`

## Agent Output Format

The agent is expected to return images in the following format:

```json
{
  "content": {
    "parts": [
      {
        "inlineData": {
          "data": "..."
        }
      }
    ]
  }
}
```

Where `data` contains the base64-encoded image.
