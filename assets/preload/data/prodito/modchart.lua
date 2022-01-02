function start (song)
	for i=0,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=1,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=2,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=3,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=4,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=5,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=6,7 do
        tweenFadeOut(i,0,0.1) -- note gone
	end
	for i=7,7 do
        tweenFadeOut(i,0,0.1) -- note gone 
	end
for i=0,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=1,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=2,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=3,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=4,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=5,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=6,7 do
        tweenFadeOut(i,0,32) -- note gone
	end
	for i=7,7 do
        tweenFadeOut(i,0,32) -- note gone 
	end
    showOnlyStrums = true -- stroom
    --tweenCameraZoom(1.05,(crochet * 11) / 1000) - test?
end
function update (elapsed)
        if curStep >= 1 and curStep < 14 then
        tweenCameraZoom(1,(crochet * 100) / 1000) -- zoom at begining
    end
    if curStep >= 0 and curStep < 8 then
        for i=0,0 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 8 and curStep < 16 then
        for i=1,1 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 16 and curStep < 24 then
        for i=2,2 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 24 and curStep < 32 then
        for i=3,3 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 32 and curStep < 40 then
        for i=4,4 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 40 and curStep < 48 then
        for i=5,5 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 48 and curStep < 56 then
        for i=6,6 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 56 and curStep < 64 then
        for i=7,7 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep > 64 then
        for i=0,7 do
            tweenFadeOut(i,1,16)
        end
    end
    if curStep >= 64 and curStep < 1000 then
        showOnlyStrums = false
    end
    if curStep >= 256 and curStep < 272 then
        tweenCameraZoom(1.2,(crochet * 11) / 1000) -- zoom when beno and bf are singing
    end
    if curStep >= 288 and curStep < 304 then
        tweenCameraZoom(1.2,(crochet * 11) / 1000) -- same as above
    end
    
end

function beatHit (beat)
    if curStep > 320 then
        tweenCameraZoom(1.02,(crochet * 11) / 1000) -- another zoom ig
    end

end

function playerTwoTurn()

end

function playerOneTurn()

end


function keyPressed (key)

end
