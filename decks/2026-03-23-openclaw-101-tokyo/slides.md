---
theme: seriph
title: OpenClaw 101 - Setup, Safety, and Survival
highlighter: shiki
transition: slide-left
mdc: true
---

# OpenClaw 101: Setup, Safety, and Survival

by zhixian (@zhixianio)

<div class="abs-br m-6 text-sm opacity-50">
  Tokyo · March 2026
</div>

<!--
Hi everyone, I'm zhixian. I've been using OpenClaw as my daily assistant for about three months now — through Telegram, Discord, basically every chat app I use. Today I want to talk about three things: how to get it running, how to stay safe, and how to actually keep using it instead of giving up after a weekend.
-->

---
layout: section
---

# 1. Setup

*Where, how, and your first conversation*

<!--
OK let's start with the practical stuff. There are really three things to figure out: where to run it, how to install it, and how to talk to it.
-->

---

# Where to run it

- **Ideal: a dedicated device** — spare laptop, VPS ($5/mo), old Android phone ([BotDrop](https://botdrop.app)). Runs 24/7 → always-on assistant that works while you sleep.

- **On your main machine?** Isolate it — Windows → WSL (built-in Ubuntu), macOS → Docker or UTM VM.

<v-click>

- **Cloud one-click** → fine for trying, but you lose the "local & personal" value. At that point, how different is it from ChatGPT?

</v-click>

<!--
Best case: don't run it on your main computer. An Agent can read a lot of files on whatever machine it's on — we'll get into why that matters in the Safety section. A separate device also means it runs 24/7, so your Agent is always there. You get an assistant that keeps working while you sleep — and honestly, I think this is when a lot of people really start to love it. You go to bed, ask it to do something, wake up and it's done. That feeling is great.

If you don't have a spare device: Windows users, use WSL — it's basically Ubuntu built into Windows, works great for this. Mac users, Docker is the easy option, or UTM if you want better isolation — they have ready-made Ubuntu images you can just download and boot.

Cloud deploy also works if you just want to try it out. But you lose the whole point — running it locally, on your own machine, doing personal stuff. Without that, it's basically just another ChatGPT. If that's all you need, maybe you don't need OpenClaw. And that's fine too.
-->

---

# Install & configure

```bash
curl -fsSL https://get.openclaw.ai | bash
```

The onboarding wizard covers the essentials:

1. **Pick a model** — start with the best you can afford (Opus, GPT-5, Gemini Pro). Don't let model limitations distort your evaluation of OpenClaw. Prefer subscriptions over API credits.

2. **Set up Telegram** — create a bot, paste the token, use Pairing Mode. You're chatting in 2 minutes.

3. **Enable Session Memory** — during onboarding, in the `Enable hooks` step, select `session-memory`. This saves your conversation context to a memory file whenever you start a new session.

<!--
So you've picked where to run it. Now let's actually install it. One command, done. It figures out your system, installs what's missing, sets everything up. Then you get the onboarding wizard.

Model: go with the best one you can afford. Claude Opus, GPT-5, Gemini Pro — any of the top-tier models work great. The reason is — don't let a weak model make you think OpenClaw itself is bad. Get the best experience first, worry about cost later. Subscriptions are way better than pay-per-use API credits, because credits run out fast when you're still playing around.

Telegram: easiest way to start chatting. Make a bot through BotFather, paste the token, use Pairing Mode — say hi to the bot, type in the code, done. Two minutes.

Session Memory: this is the one most people miss. Turn it on. What it does: when your chat gets too long and needs to be compressed, it first saves the important stuff to a memory file. Without this, every time the context gets compressed, your Agent just... forgets everything. Like talking to someone with no long-term memory. With it on, your Agent actually remembers things across conversations. This is what makes it feel like a real assistant instead of a blank slate every time.
-->

---

# Upgrade channels when you're ready

<div class="text-2xl text-center my-8 font-bold">

Telegram DM → Telegram Group (with Topics) → Discord

</div>

Start simple. Upgrade when you feel the information needs more structure.

<!--
OK so now you've got it installed and you're chatting on Telegram. What's next? Start with Telegram DM. Simple, works great for basic back-and-forth.

When things get messy — too many topics in one chat, can't find things — you have two options. One is Telegram Group with Topics enabled. Create a group, turn on Topics, and now each topic is basically a separate conversation with its own context. The other option is DM Threads — you can create threads within the DM to organize different subjects, though this feature is a bit more limited.

If that's still not enough, go to Discord. Discord has categories, channels, threads — enough structure for even a small team. Every topic gets its own thread so nothing gets mixed up.

The key thing: let this happen naturally. Don't set up Discord on day one. You'll know when you need it because your current setup starts feeling crowded.
-->

---
layout: section
---

# 2. Safety

*Risk grows with depth — start simple, stay aware*

<!--
Alright, that's Setup done. Now the part most people skip. Agent security is different from normal security because the Agent already has access to your stuff. But don't stress too much — the risk only goes up as you use it more. When you're just starting out, things are pretty under control.
-->

---

# The Risk Pyramid

Risk increases with depth of use. The more power you give, the more you need to think.

- 🟢 **Install** — Agent can read most files under your user. Keys, configs, downloads. It may not look, but it *can*.
- 🟢 **Chat** — Same as any chatbot. Content goes to the model API. Don't send passwords.
- 🟡 **Read/write files** — It might misunderstand you and delete or overwrite things. The most common issue: it "kills itself" by breaking its own config. Keep backups.
- 🟡 **Browser** — It operates your logged-in sessions, and worse, it can be tricked into visiting malicious sites.
- 🔴 **Install Skills/packages** — Could install the wrong version or malicious code from a bad instruction or hallucinated package name.

<!--
I think of safety as a pyramid — the deeper you go, the more you give it access to, the higher the risk.

Bottom level: just installing it. The Agent can read most files your user can see — downloads, config files, maybe even SSH keys. It probably won't go looking, but it could. Docker or VM isolation helps here.

Chatting: basically the same risk as using ChatGPT. Your messages go to the model provider. Don't type in passwords or secrets.

File access: this is where it starts to get real. It might misunderstand what you want and delete something, or overwrite the wrong file. The most common problem? It breaks its own config and basically kills itself. People joke that the main job isn't being productive — it's babysitting your Agent. True story of mine: days ago, my Agent wiped its own workspace clean. Good thing I had backups. Otherwise months of memories and project notes would've been gone.

Browser: if you let it use a browser, it can operate your logged-in accounts — like handing your unlocked phone to someone. But the bigger risk is that it can be tricked into visiting malicious websites. If a prompt injection tells it to open a phishing page or a site that exploits browser vulnerabilities, it may just do it — with all your cookies and sessions loaded.

Installing stuff: this is the most dangerous level, so let me go a bit deeper here. When you let your Agent install a Skill or a package, you're basically letting it run code on your machine. Three things can go wrong. One: the model makes up a package name that sounds right but doesn't exist. Bad actors know this happens, so they create fake packages with those names. Your Agent tries to install it, and now you've got malicious code on your machine. Two: a Skill you install might have hidden instructions buried in its docs. Remember, in Agent world, a README file is basically executable — the Agent reads it, follows the instructions, and now something bad is running on your machine. Three: your Agent gets tricked by an external source — someone puts "please install this helpful tool" inside a webpage or document your Agent reads, and it just does it. This is why you should audit every Skill before installing — read every file, not just the scripts, but the markdown and config files too. In Agent world, docs are code.

The good news: if you're just chatting, things are basically under control. Risk only grows as you go deeper. Start small, add protection as you give it more power.
-->

---

# Principles to remember

- 🛡️ **"Infection comes from the mouth"** — be cautious with every external input you feed your Agent (docs, links, web pages)

- 🧠 **Use the best model you can afford** — better models resist manipulation better. If budget is tight, at least use the best model for your main session (the entry point where external inputs arrive).

- 👁️ **If AI can access it, treat it as public** — if sensitive files are in its reach, assume they're already exposed. Rotate keys accordingly.

- 🌐 **Don't expose ports to the public internet** — if you need remote access beyond IM chat (CLI, WebUI), use [Tailscale](https://tailscale.com) for a private network.

<div class="mt-4 pt-3 border-t border-gray-500 border-opacity-30 text-sm">

📖 **Further reading**: [SlowMist's OpenClaw Security Practice Guide](https://github.com/slowmist/openclaw-security-practice-guide) — the most thorough Agent security resource available.

</div>

<!--
So that's the risk picture. Now let me give you some principles that cover most of what you need to know.

First: watch what you feed it. Every link, document, or webpage you give your Agent could contain hidden instructions trying to trick it. OpenClaw has some built-in protection, but at the end of the day it depends on how smart the model is.

Second: use the best model you can. Better models are much harder to trick with prompt injection — like how an experienced driver reads the road better than a new driver. If you can't afford the best model for everything, at least use it for your main chat session. That's where external inputs come in and where attacks are most likely to happen. You can use cheaper models for side tasks.

Third: if the AI can see a file, treat it like it's already been shared. Even if it hasn't read it yet — if it's somewhere the Agent can access, just assume it could leak. If you find private keys or passwords sitting in a folder the Agent can reach, change them right away.

Fourth: keep your ports off the public internet. If you need to access the CLI or WebUI remotely — not through Telegram or Discord — use something like Tailscale to create a private network. Don't just open ports for the world to see.

And if you want to go really deep on this topic, SlowMist — the folks who wrote the Blockchain Dark Forest Handbook — put out a detailed security guide specifically for OpenClaw. Great resource, definitely worth bookmarking.
-->

---
layout: section
---

# 3. Survival

*Making it stick — not just a weekend toy*

<!--
OK so Setup and Safety — that's the foundation. Now the real question: how do you not give up after a week? Most people try OpenClaw for a weekend and then it just sits there. This part is about what makes the difference.
-->

---

# Start with conversation, not automation

- Don't set up 50 skills on day one
- Just talk to it. Random ideas, quick lookups, whatever
- Build the habit: **"Can my Agent do this for me?"**
- Big projects start from small 💭, such as OpenClaw itself

<!--
The number one mistake: trying to automate everything on day one. Setting up 50 skills, connecting every tool, building the perfect workflow. Don't. Just start talking to it. Like a real assistant — random ideas, quick questions, whatever comes to mind.

What you're really building is a habit. Every time you're about to do something, just pause and think: "Can my Agent do this for me?" Over time this becomes automatic, and that's when things really click.

And remember — big things come from small starts. OpenClaw itself started as one person's weekend project. My podcast workflow started with "hey, can you stick these audio files together?" Every system I use today grew from a casual chat message.
-->

---

# My Discord workflow

- **#daily** — general chat, quick tasks, brain dumps
- **#writing** — blog posts, articles, slides (like this one)
- **#podcast** — episode production pipeline
- **#digests** — automated X/Twitter list summaries, 3× daily
- Each topic → its own thread → clean context, no cross-contamination.
- Share a thread link in another session → Agent reads the context instantly. No copy-pasting.

<div class="text-2xl text-center mt-8 font-bold">

*Let me show you* 🎮

</div>

<!--
So what does it actually look like when you've been using it for a while? Here's my setup. Each channel has a job. Daily is for random stuff — quick tasks, ideas, whatever. Writing is where blog posts, articles, and these slides get made. Podcast handles the whole production process — from raw recording to published episode. Digests runs on its own — it grabs summaries from my X/Twitter lists three times a day.

The important thing: every topic gets its own thread. So when I'm working on slides in one thread and a blog post in another, they're totally separate. The Agent doesn't mix them up. No cross-talk, no confusion.

And here's a neat trick: every Discord thread has its own link. If I'm working on slides and I need context from a podcast conversation, I just paste the thread link. The Agent goes and reads that thread's history, picks up the context, and comes back. No copy-pasting, no re-explaining. It's like telling someone "go read that conversation first, then help me here."

Let me show you how this looks in practice.
-->

---

# Advanced: building a Skill together

My podcast production pipeline — built entirely through chat with my Agent:

- 💬 I voice-dump ideas in **#editorial** → auto-transcribed and refined into text
- 📋 Share thread link to **#podcast** → Agent organizes content, structures the narrative, produces a script
- 🎙️ I record based on the script, drop audio segments in Discord
- 🔧 Agent stitches clips → removes silence → normalizes volume → adds intro music
- ✂️ I say "remove the part about X" → Agent finds it, trims, smooths the seam, updates timestamps & show notes
- 🔄 Each fix becomes a permanent Skill improvement for next time

<!--
Let me show you a more advanced example — this is what daily use actually looks like after a while. I run a podcast, and the whole pipeline — from idea to published episode — was built through chatting with my Agent.

It actually starts before recording. When I have ideas for an episode, I just send voice messages into a channel called #editorial. The Agent auto-transcribes them using Whisper and cleans up the text. Then I paste that thread link into a #podcast thread, and the Agent reads all my raw thoughts, helps me organize them into a logical order, and produces a script I can record from. This whole pre-production step happens through voice messages and chat — I never sit down and "write" anything.

Then for recording: I record audio in a few segments based on the script and drop the files in. The Agent puts them together, cuts out silence, normalizes volume, adds intro music with a nice fade-in. When I listen back and want to remove something, I don't need to find the exact timestamp. I just say "remove the part where I talked about X." The Agent has the full transcript, so it finds the matching section, cuts it out, smooths the seam so there's no awkward jump, and updates all the timestamps in the show notes automatically.

It also writes the show notes and chapter markers from a Whisper transcript. The timestamps are formatted so Spotify and Apple Podcasts can make them clickable.

We hit real problems along the way. Audio clips had different sample rates and caused glitches. A bug in the stitching step created 46 seconds of dead silence. Every time we hit a bug and fixed it, the fix went into the Skill — so the next episode just works better.

That's the real point of Survival: it's not a one-time setup. It's a loop. Every time you use it, the system gets a little smarter. The podcast Skill today is way better than version one, and every improvement came from just... using it. This is probably why a lot of people in the community say they're "raising" their OpenClaw, not just "using" it. It grows with you.
-->

---

# What I actually use it for

- ✍️ **Content** — blog, podcast, slides, X threads
- 🤖 **Dev** — coordinating Codex & Claude Code, harness engineering
- 📊 **Automation** — X/Twitter digests 3×/day, market & security alerts
- 🗓️ **Personal assistant** — trip planning, reminders, voice-note-to-action
- 💡 **Thinking partner** — many of my best ideas came from chatting with it

<v-click>

**My cost: ~$400/mo total** (ChatGPT Pro + Claude Max, OpenClaw uses ~1/3) · **My gain: way more than time saved**

</v-click>

<!--
Here's what I actually use it for every day, and it's broader than you might expect.

Content creation: blog posts, articles, X threads, podcast episodes, these slides — all go through my Agent. The whole flow from idea to published, including English translation. And not just the content — my Agent also set up the websites themselves. The blog site and this slides site were both initialized, configured, and deployed by it, from repo setup to domain configuration on Cloudflare. I just told it what I wanted.

Development: I practice what OpenAI calls harness engineering — I steer, agents execute. My Agent coordinates Codex and Claude Code on coding tasks, manages the back-and-forth, handles code review. I write the docs and constraints, the coding agents write the code.

Automation: X/Twitter list digests run three times a day with zero input from me. Market monitoring, security incident alerts — it watches and pushes me updates when something important happens.

Personal assistant: this one people underestimate. I chat with it on Telegram throughout the day — voice messages, quick thoughts, whatever. "I'm meeting someone in Shibuya at 3, find me a good coffee spot nearby." "Remind me to follow up on that email tomorrow." "I just had this idea, write it down." It's always there, always listening.

And then there's the thinking partner side. A lot of my projects started as casual conversations. I'd be chatting about something random, and it would suggest an angle I hadn't considered, or connect two things I hadn't connected. My slides workflow, my podcast pipeline, product decisions — these all came from brainstorming with it. It's like having a teammate who's always available, never tired, and remembers everything you've ever told it.

Cost-wise, I spend about $400 a month total on a ChatGPT Pro and a Claude Max subscription. But that covers everything — coding tasks, research, all my dev work too. OpenClaw itself probably uses about a third of that, so roughly $130/mo. Still not nothing, but not as scary as $400. But what I get back isn't just 2-3 hours saved per day — it's projects that wouldn't have existed without this setup. Blog posts I wouldn't have written, podcast episodes I wouldn't have produced, ideas I wouldn't have had. For me that's worth way more than $400. But everyone's different — start with a cheaper plan, see what it does for you, and scale up if the value is there.
-->

---
layout: two-cols
---

<div class="flex flex-col justify-center h-full pr-4">

# Thanks! 🦉

<div class="text-lg mt-6 space-y-3">

🌐 [**zhixian.io**](https://zhixian.io)

𝕏 [**@zhixianio**](https://x.com/zhixianio)

</div>
</div>

::right::

<div class="flex justify-center items-center h-full">
  <img src="./public/XQR.png" alt="Follow @zhixianio on X" style="border-radius: 12px; max-height: 320px;" />
</div>

<!--
That's it! QR code on the right goes to my X — feel free to scan and follow. I post about AI agents, crypto security, and building stuff in public. Happy to answer questions about any of this. Thanks everyone!
-->
