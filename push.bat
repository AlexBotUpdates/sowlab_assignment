call flutter clean
git init
git config user.name "AlexBotUpdates"
git config user.email "aleximercer69@gmail.com"
git add .
git commit -m "Clean up and fix network payload for register API"
git branch -M main
git remote remove origin
git remote add origin https://github.com/AlexBotUpdates/sowlab_assignment.git
git push -u origin main
