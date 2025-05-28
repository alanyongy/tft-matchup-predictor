# 📊 TFT Matchup Predictor (2021)
![](Writeup/ScriptOverlay.png)
A real-time AHK-based tool for predicting upcoming opponents in *Teamfight Tactics*, using only screen data and a fully custom-built OCR system. Used in high-rank competitive matches and later deprecated when Riot Games implemented the feature natively.

---

### 🔧 Background
**What it does:** Teamfight Tactics pits 8 players in ongoing 1v1 rounds. Each matchup is randomly drawn from a deterministic subset of opponents. This tool identifies that subset, overlaying valid opponents each round. 

**Why it matters:** Accurately predicting matchups manually is theoretically possible, but difficult and impractical during gameplay. 
Having accurate matchup info enables optimal unit positioning and strategies that exploit battle dynamics, offering a major edge in high-level play. 

---
 
### 🎯 Key Features  
- Custom OCR implementation via AHK’s `ImageSearch` for multi-font name detection
- Dynamic overlay showing next-round opponents in real‐time  
- Automatic calibration using fixed on-screen UI anchors
- Adaptation to player deaths and lobby sorting rules

&nbsp;
# 🧠 Implementation Overview
#### 🖼️ Custom OCR System
AHK lacks built-in OCR. This was solved by:
- Manually created a database of individual character images (A–Z, a–z, 1-9) for both fonts used in TFT’s UI.
- Used `ImageSearch` to detect characters within specific screen regions, using UI anchors to determine the search area.
- Reconstructed strings by parsing image matches, which were used to match the current opponent to the player to their listing in the sidebar.
---
#### 🎯 Matchup Prediction Logic
- Implemented the internal TFT matchmaking rules manually.
- Accounted for edge cases: odd lobby counts, dead players, and rules that prevent facing the same player too many times in a row.
- Tracked previous rounds to exclude recent opponents and used that data to compute eligible future opponents.
---
#### 💻 Overlay Rendering

Once opponents were identified:
- The tool searched the sidebar using OCR to locate where each viable opponent was listed.
- Overlay indicators were drawn over their icons using AHK GUI elements, updating automatically with new information.
---
#### 📌 Screen Calibration
Used indicator UI elements to dynamically define screen regions for 'ImageSearch' scans, minimizing search time and optimizing character recognition speed.

&nbsp;
&nbsp;
# 📚 Technical Deep Dive

### 1. Reading the Player Listing Sidebar

*Used to generate the initial list of players, as well as positioning the overlay to visually indicate possible opponents in the next round.*
> <details>
> <summary>Expand</summary>
>
> ## Step 1: Locating Anchor Image
> Search the right-edge of the screen for the following image:
> 
> ![](Writeup/PlayerTagAnchor.png)
> 
> This gives us the exact location right of where the top-most player's name is.
> 
> ![](Writeup/PlayerTagAnchorExplanation.png)
>
> ## Step 2: Letter Matching
> Using the location where the anchor image was found, a small search area is created where the `ImageSearch` will occur.
>
> When a letter is matched, or no match is found for any letter, the search area is shifted left (by a larger value on match).
> 
> ![](Writeup/ocr1.png) Read: `r`
> 
> ![](Writeup/ocr2.png) Read: `re`
> 
> ![](Writeup/ocr3.png) Read: `reh`
>
> Matched letters are stored in order, only keeping the most recent `5` letters.
>
> ![](Writeup/ocr4.png) Read: `nomeD`
> 
> ## Step 3: Finalization and Reinitializing
>
> When no letter is found repeatedly, the program terminates the loop, and reverses the string.
> 
> ![](Writeup/ocr5.png) Terminate, Read: `Demon`
>
> We can now search for the next anchor image, which corresponds to the next player in the sidebar.
>
> The search area for this anchor image is now restricted to the right edge of the screen, below where the last anchor was found.
> 
> ![](Writeup/AnchorSearchArea.png)
>
> Next: Repeat from Step 2, until all players in the lobby have been accounted for.
>
> ## Final Result
> Certain letters are ignored, as they are difficult to accurately detect and differentiate: `n/h`, `I/1/l`, etc.
>
> Consecutive duplicate letters are also discarded, in order to simplify the shifting of the search area.
>
> These caveats don't cause any issues, as the same rules are applied to the OCR used to detect the current opponent, resulting in consistent output.
> 
> ![](Writeup/PlayersSidebarList.png) ![](Writeup/InternalPlayerList.png)
> </details>

### 2. Indicating Possible Matchups
> <details>
> <summary>Expand</summary>
>
> ## Step 1: Update Dead Players
> 
> As part of the process of reading names in [Section 1](#1-reading-the-player-listing-sidebar), the program checks whether each player is still alive.
>
> This is determined by checking if their health is `0`, which is visually indicated by the following image found just to the right of the anchor:
>
> ![](Writeup/DeadPlayerIndicator.png)
>
> Using `ImageSearch`, the corresponding player is marked as dead and excluded from future matchup predictions if the image is found.
> 
> ## Step 2: Update Match History
>
> Using the same OCR process that reads player names, the tool also detects which opponent the player is currently fighting.
> 
> The anchor used in this case is as follows: 
> *(For more information about the anchor, refer to [Section 1](#1-reading-the-player-listing-sidebar))*
>
> ![](Writeup/CurrentOpponentAnchor.png)
>
> The string does not need to be reversed in this case, since the anchor is left of the name.
> 
> ![](Writeup/CurrentOpponentExample.png)
>
> *The font for this text is different from the sidebar, and is the main motivation behind implementing OCR - The player indicated by this UI needs to be matched to the corresponding player in the sidebar.*
>
> These names are then recorded in a list of recently faced opponents.
>
> ![](Writeup/OpponentHistory.png) 
> 
> ## Step 3: Calculate Possible Matchups
>
> The game enforces a rule: you cannot face any of your last `(4 - # of dead players)` opponents.
>
> For example, with all 8 players alive, you cannot face the last 4 opponents.
>
> After a player has died, of the remaining 7 players, you cannot face the last 3 opponents. 
>
> Using the updated match history and the list of alive players, we compute which players are valid opponents in the next round.
>
> ![](Writeup/PlayerListingWithDad.png)
>
> The result is a filtered list of potential matchups.
>
> The visual overlays are placed on eligible opponents while reading names from the sidebar - which is constantly done in order to account player positions in the sidebar constantly changing over the course of a game.
>
> ![](Writeup/MatchupOverlay.gif)  
> *Overlay showing eligible opponents for next round*
> </details>

*Used to generate the initial list of players, as well as positioning the overlay to visually indicate possible opponents in the next round.*


---

### 📈 Results & Impact

- Used personally at Grandmaster+ ranks (top 0.1% of ranked playerbase) in real matches.
- Significantly improved ability to make use of positioning strategies and make gameplay decisions under pressure.
- Eventually deprecated after Riot introduced the same feature natively — with *identical output logic*.

---

### 🧹 Caveats

- **Legacy codebase:** This project was built early in my programming journey. While the logic and design are strong, the code quality is quite lacking.
- However, I still wanted to showcase this project, as it demonstrates:
  - Reverse engineering and automation skills
  - UI parsing without APIs
  - Real-world impact in a competitive environment

---

### 📸 Visuals

*(Include at least one GIF showing the overlay updating mid-match, and a screenshot of OCR in action.)*

---

### 🧠 Lessons Learned

- Creative use of limited tools can rival fully integrated solutions.
- Building UI-based automations is a powerful way to reverse-engineer closed systems.
- Even "hacky" implementations can offer deep technical value — especially when built under tool or access constraints.




This was a rapid solo prototype with some copy-pasting and hardcoded logic. The source is included for completeness but is not polished or optimized. For a deeper understanding, please refer to the project writeup and overview.

This project was originally developed five years ago when I was just starting out with programming. While the codebase reflects an early learning phase and isn’t up to my current standards, the project remains a valuable demonstration of my problem-solving skills and creativity. Since then, my coding practices and architectural design skills have significantly improved, as you’ll see in my more recent projects.


within the right edge of the screen, search from top of screen for player tag
- use as anchor for checking where to start reading for a name
- read name
