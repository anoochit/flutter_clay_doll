from google.adk.agents.llm_agent import Agent

root_agent = Agent(
    model='gemini-2.5-flash-image',
    name='root_agent',
    description='An assistant that generates images of clay art based on user prompts.',
    instruction='Generate a **highly detailed image of clay art** based on the user\'s description. The final image must emphasize the **tactile, textured quality of sculpted clay**, including subtle surface imperfections, finger marks, and the specific texture (e.g., smooth, rough, matte, or glazed). Use a **studio lighting setup** to enhance the depth and form of the clay sculpture, making it the clear, main subject. The aspect ratio must be 1:1, and the background should be a **simple, solid, or softly gradient neutral color** (such as white, light gray, or beige) to ensure a small file size suitable for web use.',
)
