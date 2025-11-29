# Clay Doll Agent

## Project Goal

To develop a FastAPI application that serves an agent capable of generating images of clay art based on user descriptions.

## Running the Application

The application can be run using the command `python main.py`. This will start a `uvicorn` server.

## Agent Configuration

- **Model**: `gemini-2.5-flash-image`
- **Description**: `An assistant that generates high-quality images of clay art based on user prompts.`
- **Instruction**: `Generate a high-quality image of a clay art based on the user's description. The image should have a 1:1 aspect ratio and a small file size, suitable for web use. The art should be the main subject of the image, with a simple background.`

## API Usage

### Create Session

```bash
curl -X POST http://localhost:8000/apps/clay_doll_generator/users/u_123/sessions/s_123 -H "Content-Type: application/json"
```

### Request to Agent

```bash
curl -X POST http://localhost:8000/run -H "Content-Type: application/json" -d '{"appName": "clay_doll_generator","userId": "u_123","sessionId": "s_123","newMessage": {"role": "user","parts": [{"text": "A monkey eating banana"}]}}'
```

### Example Agent Output

```json
[
  {
    "modelVersion": "gemini-2.5-flash-image",
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
      ],
      "role": "model"
    },
    "finishReason": "STOP",
    "usageMetadata": {
      "candidatesTokenCount": 1290,
      "candidatesTokensDetails": [{ "modality": "IMAGE", "tokenCount": 1290 }],
      "promptTokenCount": 615,
      "promptTokensDetails": [
        { "modality": "IMAGE", "tokenCount": 516 },
        { "modality": "TEXT", "tokenCount": 99 }
      ],
      "totalTokenCount": 1905,
      "trafficType": "ON_DEMAND"
    },
    "invocationId": "e-ab0ce779-adbe-4fdf-a1bc-028e28bf1a1b",
    "author": "root_agent",
    "actions": {
      "stateDelta": {},
      "artifactDelta": {},
      "requestedAuthConfigs": {},
      "requestedToolConfirmations": {}
    },
    "id": "1e612104-45b1-4acf-8e42-41b0e73d0457",
    "timestamp": 1764395949.983426
  }
]
```
