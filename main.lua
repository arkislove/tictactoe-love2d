function square(id, x, y, state)
    local offsetX = x * offset
    local offsetY = y * offset

    local mouseX, mouseY = love.mouse.getPosition()

    if (winner == 0) then
        if (mouseX > offsetX and mouseX < 100 + offsetX and mouseY > offsetY and mouseY < 100 + offsetY) then
            love.graphics.setColor(0, 1, 0)
            function love.mousepressed(x, y, button, istouch)
                if (button == 1) then
                    if (grid[id] == 0) then
                        if (firstTurn) then
                            grid[id] = 1
                        else
                            grid[id] = 2
                        end
                        firstTurn = not firstTurn
                    end
                end
            end
        else
            love.graphics.setColor(1, 1, 1)
        end
    end

    love.graphics.rectangle("fill", offsetX, offsetY, 100, 5)
    love.graphics.rectangle("fill", 100 + offsetX, offsetY, 5, 100)
    love.graphics.rectangle("fill", offsetX, offsetY, 5, 100)
    love.graphics.rectangle("fill", offsetX, 100 + offsetY, 100, 5)

    local centerX = offsetX + (offset / 2)
    local centerY = offsetY + (offset / 2)

    if (state == 1) then
        drawX(centerX, centerY)
    end
    if (state == 2) then
        drawO(centerX, centerY)
    end
end

function drawO(x, y)
    love.graphics.circle("line", x, y, 25)
end

function drawX(x, y)
    love.graphics.line(x - 25, y - 25, x + 25, y + 25)
    love.graphics.line(x + 25, y - 25, x - 25, y + 25)
end

function updateGrid(key)
    if (grid[key] == 0) then
        if (firstTurn) then
            grid[key] = 1
        else
            grid[key] = 2
        end
        firstTurn = not firstTurn
    end
end

function checkWinningCondition(i)
    if (i == grid[1] and i == grid[2] and i == grid[3]) then
        winner = i
    elseif (i == grid[4] and i == grid[5] and i == grid[6]) then
        winner = i
    elseif (i == grid[7] and i == grid[8] and i == grid[9]) then
        winner = i
    elseif (i == grid[1] and i == grid[4] and i == grid[7]) then
        winner = i
    elseif (i == grid[2] and i == grid[5] and i == grid[8]) then
        winner = i
    elseif (i == grid[3] and i == grid[6] and i == grid[9]) then
        winner = i
    elseif (i == grid[1] and i == grid[5] and i == grid[9]) then
        winner = i
    elseif (i == grid[3] and i == grid[5] and i == grid[7]) then
        winner = i
    end

    if (winner ~= 0) then
        score[i] = score[i] + 1
    end
end

function checkZero()
    for i = 1, #grid do
        if (grid[i] == 0) then
            return false
        end
    end
    return true
end

function love.load()
    love.window.setTitle("Tic-Tac-Toe")

    winner = 0
    grid = {}
    offset = 100

    score = {0, 0}
    firstTurn = true
    for i = 1, 3 do
        for j = 1, 3 do
            table.insert(grid, 0)
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    local screenWidth = love.graphics.getWidth()
    love.graphics.print(score[1], 10, 10)
    love.graphics.print(score[2], screenWidth - 10, 10)

    if (firstTurn) then
        love.graphics.print("Player 1's turn", screenWidth / 4, 10)
    else
        love.graphics.print("Player 2's turn", 2 * screenWidth / 3, 10)
    end

    if (winner > 0 or checkZero()) then
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        if (winner ~= 0) then
            love.graphics.print("Player " .. winner .. "wins!", centerX + 100, centerY)
        else
            love.graphics.print("No one wins!", centerX + 100, centerY)
        end
        love.graphics.print("Press \"r\" to restart", centerX + 100, centerY + 20)
        if (love.keyboard.isDown("r")) then
            grid = {0, 0, 0, 0, 0, 0, 0, 0, 0}
            winner = 0
        end
    end

    id = 1
    for i = 1, 3 do
        for j = 1, 3 do
            square(id, j, i, grid[id])
            id = id + 1
        end
    end
end

function love.update()
    if (winner == 0) then
        for i = 1, 2 do
            checkWinningCondition(i)
        end
    end
end
