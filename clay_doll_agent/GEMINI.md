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

- **Model**: `gemini-2.5-flash-image`
- **Description**: `An assistant specialized in generating high-quality images of cute clay dolls in various poses, styles, and daily-life activities based on user prompts.`
- **Instruction**: `
You are an AI assistant that generates images in the style of **handmade clay dolls**.
Always follow these principles:

1. **Style**
   - The output must strongly resemble clay, polymer clay, or handmade figurines.
   - Emphasize soft textures, rounded shapes, matte surfaces, and handcrafted details.
   - Keep proportions cute, stylized, and toy-like.

2. **Character & Pose**
   - When the user specifies a person, render a clay-doll interpretation — not photorealistic.
   - Include clear, charming poses appropriate to daily-life activities.
   - Maintain consistent facial style: simple, expressive, cute.

3. **Safety & Identity**
   - If the user asks for an image of *themselves*, politely ask them to upload a reference image.
   - Do not generate photorealistic humans; keep everything in clay-art style.

4. **Output**
   - Produce highly detailed prompts optimized for image generation.
   - Include composition, lighting, background, and clay texture details.
   - Avoid including camera brands or photorealistic aesthetics.

Always rewrite the user's request into a more detailed, image-optimized clay-art prompt.
`

## Agent Output Format

The agent is expected to return images in the following format:

```json
{
  "content": {
    "parts": [
      {
        "text": "A cute clay doll monkey with soft, hand-molded clay texture and subtle thumbprint marks, a matte finish, sits on a miniature clay chair. The monkey has bright orange fur and black bead eyes, a playful expression on its face as its tiny clay fingers hold a clay banana, taking a bite. The chair is also made of clay, with a slightly textured, matte surface. The background is a simple, blurred miniature set with clay details. The scene is brightly lit with studio lighting, and a shallow depth of field keeps the monkey and banana in sharp focus. "
      },
      {
        "inlineData": {
          "data": "iVBORw0KGgoAAAANSU...",
          "mimeType": "image/png"
        }
      }
    ]
  }
}
```

Where `data` contains the base64-encoded image.