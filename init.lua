local speaker = hs.speech.new("Samantha")

function say(msg)
speaker:speak(msg)
print(os.date("%H:%M") .. " -> " .. msg)
end

local announcements = {
["04:00"] = "Wake up. Fajr prayer time.",
["04:05"] = "Second alarm. Get out of bed.",
["04:10"] = "Third alarm. Move now.",
["04:15"] = "Final alarm. Get up immediately.",
["04:30"] = "Math Block One begins now. Three hours. Lock in.",
["07:30"] = "Breakfast time. Thirty minutes only.",
["08:00"] = "Math Block Two begins now. Five hours.",

["13:00"] = "Dhuhr prayer and lunch.",
["14:00"] = "Python Deep Dive Part One begins.",
["15:30"] = "Statistics and Artificial Intelligence preparation begins.",

["16:30"] = "Asr prayer and tea.",

["17:15"] = "Python Deep Dive Part Two A begins.",

["18:20"] = "Maghrib prayer. Stop everything.",
["18:30"] = "Dinner time.",
["18:50"] = "Python Deep Dive Part Two B begins.",

["19:45"] = "Statistics and Artificial Intelligence Part Two begins.",

["21:00"] = "Isha prayer.",
["21:15"] = "Daily review begins.",
["21:45"] = "Daily quota complete. Sleep release."
}

local lastMinute = ""

hs.timer.doEvery(20, function()

local now = os.date("%H:%M")

if now ~= lastMinute then
    lastMinute = now

    if announcements[now] then
        say(announcements[now])
    end
end

end)

say("Mission Control Online")
