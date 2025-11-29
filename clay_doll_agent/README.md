
create session:

```bash
curl -X POST http://localhost:8000/apps/clay_doll_generator/users/u_123/sessions/s_123 -H "Content-Type: application/json"
```

request to agent:

```bash
curl -X POST http://localhost:8000/run -H "Content-Type: application/json" -d '{"appName": "clay_doll_generator","userId": "u_123","sessionId": "s_123","newMessage": {"role": "user","parts": [{"text": "A hen with eggs"}]}}'
```

```json
[
  {
    "modelVersion": "gemini-2.5-flash-image",
    "content": {
      "parts": [
        {
          "inlineData": {
            "data": "iVBORw0KGgoAAAANSU",
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
