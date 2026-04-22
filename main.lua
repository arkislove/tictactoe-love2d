function square(id, x, y, state)
    x = x * offset
    y = y * offset

    love.graphics.print(id, x + 10, y + 10)
    love.graphics.rectangle("fill", 0 + x, 0 + y, 100, 5)
    love.graphics.rectangle("fill", 100 + x, 0 + y, 5, 100)
    love.graphics.rectangle("fill", 0 + x, 0 + y, 5, 100)
    love.graphics.rectangle("fill", 0 + x, 100 + y, 100, 5)

    local centerX = x + (offset / 2)
    local centerY = y + (offset / 2)

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
    else
        return 0
    end
end

function love.load()
    winner = 0
    grid = {}
    offset = 100
    firstTurn = true
    love.window.setTitle("Tic-Tac-Toe")
    for i = 1, 3 do
        for j = 1, 3 do
            table.insert(grid, 0)
        end
    end
end

function love.draw()
    if (firstTurn) then
        love.graphics.print("Player 1's turn", 10, 10)
    else
        love.graphics.print("Player 2's turn", 10, 10)
    end

    id = 1
    for i = 1, 3 do
        for j = 1, 3 do
            square(id, j, i, grid[id])
            id = id + 1
        end
    end

    if (winner > 0) then
        local centerX = love.graphics.getWidth() / 2
        local centerY = love.graphics.getHeight() / 2
        love.graphics.print("Player " .. winner .. "wins!", centerX + 100, centerY)
        love.graphics.print("Press \"r\" to restart", centerX + 100, centerY + 10)
        if (love.keyboard.isDown("r")) then
            grid = {0, 0, 0, 0, 0, 0, 0, 0, 0}
            winner = 0
        end
    end
end

function love.update()
    for i = 1, 2 do
        checkWinningCondition(i)
    end
    if (winner == 0) then
        for i = 1, #grid do
            if (love.keyboard.isDown(tostring(i))) then
                updateGrid(i)
            end
        end
    end
end
