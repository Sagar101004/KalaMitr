# 🌟 Project Overview  

**KALAMITR** is a generative AI-first platform designed to empower local artisans by automating digital marketing. It helps them preserve and share their heritage through authentic storytelling—bridging the gap between product-focused e-commerce sites and storytelling-limited social platforms.  

Our solution is an **AI-powered marketplace assistant** that serves as the artisan’s *Mitra* (friend), simplifying complex marketing tasks into one-click or one-prompt actions. With a validated prototype, KALAMITR automates the creation and publishing of social media content enriched with culturally grounded narratives.  

---

## ✨ Unique Selling Propositions (USPs)  

- **Agentic & Safe Automation**  
  Uses a ReAct (Reasoning + Acting) loop with Gemini LLM. A secure Orchestrator validates and executes actions, ensuring trust with an auditable log.  

- **Culturally Grounded Storytelling**  
  Powered by Vertex AI embeddings and a private Knowledge Base (KB) for Retrieval-Augmented Generation (RAG). This guarantees content authenticity, heritage preservation, and provenance-backed storytelling.  

- **Seamless for Artisans**  
  Built for non-technical users. Automates entire workflows—from content generation to publishing—with a single click/prompt, freeing artisans to focus on their craft.  

---

## ⚙️ Architecture & Technologies  

**Built on Google Cloud + GenAI stack**  

- **User Layer:** Artisan & customer mobile apps  
- **Perception Module:** Extracts intent from artisan inputs  
- **Orchestrator:** Python-based “brain” that validates and routes LLM outputs  
- **Gemini LLM:** Generates captions, hashtags, and action suggestions  
- **Toolbox Microservices:** Containerized tasks (e.g., `post_reel`, `query_kb`) on Cloud Run  
- **Storage & KB:** Firestore for user data, embedding-based KB for RAG, Cloud Storage for media  

---

## 🚀 End-to-End Workflow  

A single prompt → a published story  

1. **Artisan Input** → e.g., *“post my clay vase reel.”*  
2. **Intent Recognition** → Perception Module detects `post_reel` intent  
3. **LLM Reasoning** → Orchestrator calls Gemini LLM, enriched with KB narratives  
4. **Validation** → Orchestrator checks action safety + correctness  
5. **Execution** → Routes validated action to `post_reel` microservice  
6. **Output** → Reel published with AI-generated caption & hashtags  

---

## 🗺️ Future Scope  

- **Integrated Payments** → In-app e-commerce support  
- **Multilingual Support** → Expand KB for regional Indian languages  
- **AI-Powered Insights** → Pricing/demand recommendations for artisans  

---

## 💻 How to Run the Project & Demo Video 

*(Setup & execution instructions will be added here)*  

📽️ [Watch current app devloped Video](https://drive.google.com/file/d/18gzeeMWmZDzD0Z29npeC73uroRixQUaA/view?usp=drive_link)

![Demo Screenshot](https://github.com/Sagar101004/KalaMitr/blob/main/assets/bot_images_1.jpg)

---

## 👥 Team  

- Sagar T k – Leader – https://github.com/Sagar101004
- Ranga Gowda G P – Reserach – [LinkedIn/GitHub]  
- Vibha S Aradhya – Devloper – [LinkedIn/GitHub]  
- Dheeraj Gowda D S – Devloper – https://github.com/DheerajGowdaDS 

```
