function start (song)

end

function update (elapsed)

end

function beatHit (beat)
	if curStep % 8 >= 7  then -- fix the delay on the bpm ? -Z
	if curStep >= 0 and curStep < 256 then
		tweenCameraZoom(0.85,(crochet * 0.5) / 1000)
	end
	if curStep >= 256 and curStep < 512 then
		tweenCameraZoom(0.90,(crochet * 0.5) / 1000)
	end
	if curStep >= 512 and curStep < 768 then
		tweenCameraZoom(0.95,(crochet * 0.5) / 1000)
	end
	if curStep >= 1024 and curStep < 1280 then
		tweenCameraZoom(0.95,(crochet * 0.5) / 1000)
	end
	end
end

function stepHit (step) -- THERE WAS MORE STUFF BEFORE but the camera was glitching and time is short so... gone -Z
	if curStep == 496 or curStep == 502 or curStep == 506 or curStep == 508 or curStep == 1008 or curStep == 1014 or curStep == 1018 or curStep == 1020 then
		tweenCameraZoom(1.10,(crochet * 1) / 1000)
	end
end

function playerTwoTurn()

end

function playerOneTurn()

end