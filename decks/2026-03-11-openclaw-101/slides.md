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
  Singapore · March 2026
</div>

<!--
Self-intro: zhixian, been running OpenClaw daily for a few months now. Three parts today: getting it running, keeping it safe, and making it actually useful long-term.
-->

---
layout: section
---

# 1. Setup

*Where, how, and your first conversation*

<!--
Let's start with the practical stuff. Three decisions: where to run it, how to install it, and how to talk to it.
-->

---

# Where to run it

<v-clicks>

- **Ideal: a dedicated device** — spare laptop, VPS ($5/mo), old Android phone ([BotDrop.app](https://botdrop.app)). Runs 24/7 → always-on assistant that works while you sleep.

- **On your main machine?** Isolate it — Windows → WSL (built-in Ubuntu), macOS → Docker or UTM VM.

- **Cloud one-click** → fine for trying, but you lose the "local & personal" value. At that point, how different is it from ChatGPT?

</v-clicks>

<!--
If you have conditions, try NOT to deploy on your primary device. An Agent has broad file access — we'll talk about why that matters in the Safety section. Plus a dedicated device runs 24/7, so your Agent is always available.

If you must use your main machine: Windows → WSL, Mac → Docker or UTM VM (pre-built Ubuntu images, ready to go). 

Cloud one-click works for a quick test drive, but you lose the core value — running locally, doing personal things. If you don't need that, you might not need OpenClaw at all, and that's a valid conclusion too.
-->

---

# Install & configure

```bash
curl -fsSL https://get.openclaw.ai | bash
```

The onboarding wizard covers the essentials:

<v-clicks>

1. **Pick a model** — start with the best you can afford. Don't let model limitations distort your evaluation of OpenClaw. Prefer subscriptions over API credits.

2. **Set up Telegram** — create a bot, paste the token, use Pairing Mode. You're chatting in 2 minutes.

3. **Enable Session Memory** — ```session-memory``` in ```Enable hooks``` section. Save session context to memory when /new or /reset command is issued.

</v-clicks>

<!--
Installation is one command. Then onboarding. Model choice: pick the strongest within your budget — Opus if you can get Claude Pro. Subscriptions are better than API credits because credits burn fast.

Chat channel: Telegram is simplest to start. Create a bot via BotFather, paste the token, use pairing mode — say hi to the bot, enter the code. Done.

Context summarization: turn this on. When conversation gets long enough to compress, it summarizes first and saves key info to daily memory files. This is what makes it feel like a real assistant instead of a stateless chatbot. 
-->

---

# Upgrade channels when you're ready

<div class="text-2xl text-center my-8 font-bold">

Telegram DM → Telegram Group → Discord

</div>

Start simple. Upgrade when you feel the information needs more structure.

<!--
Start with Telegram DM. If conversations get complex, try Telegram Group for one extra layer of hierarchy. If that's still not enough, Discord — channels, threads, categories. I'll show you my Discord setup later.
-->

---
layout: section
---

# 2. Safety

*Risk grows with depth — start simple, stay aware*

<!--
Now the part most people skip. Agent security is different from traditional security — the Agent is already authorized.

But don't overthink it — the risks only grow as you go deeper into using OpenClaw. When you're just getting started, things are relatively contained and manageable.
-->

---

# The Risk Pyramid

Risk increases with depth of use. The more power you give, the more you need to think.

<v-clicks>

- 🟢 **Install** — Agent can read most files under your user. Keys, configs, downloads. It may not look, but it *can*.
- 🟢 **Chat** — Same as any chatbot. Content goes to the model API. Don't send passwords.
- 🟡 **Read/write files** — It might misunderstand you and delete or overwrite things. The most common issue: it "kills itself" by breaking its own config. Keep backups.
- 🟡 **Browser** — It operates your logged-in sessions. Like handing your unlocked phone to someone else.
- 🔴 **Install Skills/packages** — Could install the wrong version or malicious code from a bad instruction or hallucinated package name.
- 🔴 **Autonomous execution** — Mistakes compound silently. It may have been breaking things in the background long before you notice.

</v-clicks>

<!--
In my view, security risk is like a pyramid that increases with depth of use — the deeper you go, the more permissions you give, the higher the risk.

First level: just installing and configuring the model. The main exposure is that the Agent can read most files under your user permissions — downloads, config files, keys. It might not proactively read them, but the attack surface exists. If you want to protect against this, use Docker or VM isolation.

When you start chatting, the risk is mainly information disclosure. Not much different from using ChatGPT — content goes to their servers. Don't send sensitive info, especially keys or passwords.

Going deeper, you might need it to read and write files. The risk here is the model misunderstanding your intent, or doing extra operations that delete or corrupt files. For OpenClaw users, the most common issue is it "killing itself" — messing up its own config. People joke that instead of boosting productivity, the main daily job is configuring and babysitting it. For me, once it initialized its own workspace for no reason — luckily I had backups, otherwise all the memories/projects would have been gone.

If you let it operate a browser for automation, it gets access to your logged-in accounts. Like logging into your account and letting someone else use it. If a malicious link gets injected into the model's memory, visiting it creates real risk.

Further down: installing Skills or software through it. You might be "inviting the wolf in." The model could receive bad instructions or links and install the wrong version or even malware.

Finally, long-running autonomous tasks. Error probability gets amplified. It might have been silently breaking things in the background for a long time before you notice, until serious consequences hit.

Bottom line: risk scales with permissions and depth. Don't panic — if you're just chatting, the risk is manageable. Be aware of local file access, do isolation, and keep backups.
-->

---

# Three principles to remember

<v-clicks>

- 🛡️ **"Infection comes from the mouth"** — be cautious with every external input you feed your Agent (docs, links, web pages)

- 🧠 **Use the best model you can afford** — better models resist manipulation better. Like an experienced driver vs a new driver navigating traffic.

- 👁️ **If AI can access it, treat it as public** — if sensitive files are in its reach, assume they're already exposed. Rotate keys accordingly.

</v-clicks>

<!--
Three principles that cover 80% of safety. 

First: "infection comes from the mouth" — every external document, link, or web page you give the Agent is a potential attack vector. OpenClaw's webfetch has a wrapper layer with warnings, but ultimately it depends on the model's judgment. 

Second: use the best model you can afford — stronger models are significantly better at detecting prompt injection. Like an experienced driver vs a new driver reading the road. 

Third: if the AI can access a file, treat it as already public. Whether it actually reads it or not, if it's in the accessible scope, assume it could leak. If you find sensitive files exposed, rotate those credentials.
-->

---

# Further reading

<v-clicks>

- 📖 [**SlowMist's OpenClaw Security Practice Guide**](https://github.com/slowmist/openclaw-security-practice-guide)
- From the team behind the *Blockchain Dark Forest Self-Rescue Handbook*
- Covers red-line commands, audit protocols, daily automated checks
- The most thorough Agent security resource available

</v-clicks>

<!--
If you want to go deeper, SlowMist — the team behind the famous Blockchain Dark Forest Self-Rescue Handbook — published a dedicated OpenClaw security practice guide. 

It covers red-line and yellow-line command rules, Skill audit protocols, daily automated security checks, and known limitations. 

It's the most thorough resource on Agent security right now. Highly recommend bookmarking it.
-->

---
layout: section
---

# 3. Survival

*Making it stick — not just a weekend toy*

<!--
You've installed it, you've secured it. Now — how do you not abandon it after a week?
-->

---

# Start with conversation, not automation

<v-clicks>

- Don't set up 50 skills on day one
- Just talk to it. Random ideas, quick lookups, whatever
- Build the habit: **"Can my Agent do this for me?"**
- Big projects start from small 💭

</v-clicks>

<!--
The biggest mistake is trying to automate everything immediately. Don't. 

Start by chatting — treat it as a personal assistant. Got an idea? Tell your Agent. Need to check something? Ask your Agent. 

The habit you're building is reaching for your Agent instead of doing things manually. Once that's natural, the productivity follows.

Big things always start from small conversations.
-->

---

# Common pitfalls (from 60+ days)

<v-clicks>

- **Upgrades** — don't blindly upgrade. Read the changelog. Recent versions have had breaking changes.
- **Config** — let the Agent read docs first (`docs.openclaw.ai/llms.txt`). Use CLI, don't hand-write JSON.
- **Browser** — on Linux, expect setup friction. `openclaw profile + playwright` or Chromium + CDP.

</v-clicks>

<!--
Some pitfalls from my experience. 

Upgrades: don't auto-upgrade, recent versions had breaking changes — read changelogs. 

Config: never hand-edit JSON, use CLI or let the Agent do it after reading the docs. 

Browser on Linux is a whole adventure — playwright setup, finding Chrome, plugin prompts. All solvable, but expect to hit them.
-->

---

# Know what you're using it for

<v-clicks>

- **Making money** 💰 — Can it help you earn more, or do things you couldn't before?

- **Saving time** ⏰ — Does the time saved cover your API costs?

- **Exploring** 🔬 — Spin up multiple instances, experiment, enjoy the process

- No wrong answer. But having *an* answer helps you not give up.

</v-clicks>

<!--
This is the question most people skip — and the main reason they give up after a week.

Making money: freelance work, content creation, side projects — can the Agent touch any of your revenue flows?

Saving time: build the habit of asking "can my Agent do this?" But be honest about API costs — track your first month, use subscriptions over pay-per-token.

Exploring: totally valid. Spin up multiple instances, try different models, see what breaks. Some of my best use cases came from unplanned experiments.

Pick your bucket. When things get frustrating — and they will — knowing WHY you're doing this helps you push through.
-->

---

# My Discord workflow

<v-clicks>

- **#daily** — general chat, quick tasks, brain dumps
- **#writing** — blog posts, articles, slides (like this one)
- **#podcast** — episode production pipeline
- **#digests** — automated X/Twitter list summaries, 3× daily
- Each topic → its own thread → clean context, no cross-contamination.

</v-clicks>

<v-click>

*Let me show you* 🎮

</v-click>

<!--
Here's what it looks like when you've been using it for a while. Each channel has a purpose, every topic gets its own thread. The Agent keeps context separate — no conversations bleeding into each other. This is the Discord upgrade path in action. Let me switch over and give you a live demo.
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
That's it! My X profile is on the right — feel free to follow. Happy to take questions about setup, safety, or how to actually make it work for you.
-->
