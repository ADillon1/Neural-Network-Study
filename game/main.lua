require("scripts.framework")

local default_x = 600
local default_y = 300
local cam_offset = vector:new()

-- Neural Network
local num_neurons = 10
local w = {}
local o = {}
local training_x = { }
local training_y = { }
local training_size = 10
local iterations = 0
local iterations_per_frame = 1024
local change = {}
local learning_rate = 0.01
local training = false
local step = false




-- Graphing Data
graph = debugGraph:new(default_x /2, default_y /2 +200, 300, 300, training_size)
graph2 = debugGraph:new(default_x /2, default_y/2 +200, 300, 300, training_size)

function activation(x)
    return 1 / (1 + math.exp(-2 * x))
end

function reset()
    for i = 1, (10) do
        w[i] = math.random() / 100
    end

    for i = 1, (#training_x) do
        training_y[i] = training_x[i] * training_x[i]
        graph:update(i, training_y[i])
    end

    for i = 1, (10) do
        graph2:update(i, get_output(training_x[i]))
    end

    for i = 1, (100) do
        print()
    end
    print("Info:")
    print("Iterations Per Step: " .. iterations_per_frame)
    print("Function to Approximate: x^2")
    print()
    print("Press S to step through a frame.")
    print("Press Space to toggle running the learning algorithm.")
    print("Press R to reset the algorithm and graphs.")
end

function get_output(input)
    sum = 0

    for j = 1, (num_neurons) do
        sum = sum + w[j] * activation(input - (j-1)/num_neurons)
    end

    return sum
end

function partial_deriv(index)
    sum = 0

    for i = 1, (#training_x) do
        sum = sum + (o[i] - training_y[i]) * activation(training_x[i] - (index-1)/num_neurons)
    end

    return 2 * sum
end

function Calculated_Errors()
   sum = 0
   len = #training_x
   for i = 1, (len) do
        sum = sum + (o[i] - training_y[i]) * (o[i] - training_y[i])
   end

   return sum
end

function love.load()
    print("lua version:", _VERSION)

    sum = 0
    for i = 1, (training_size) do
        training_x[i] = sum
        sum = sum + 1 / training_size
    end

    reset()

end

function love.keypressed(key)
    if key == "r" then
        reset()
        training = false
        step = false
        iterations = 0

    elseif key == "s" then
        step = true
    elseif key == "space" then
        if training == false then
            training = true
        else
            training = false
        end
    end
end

function love.update(dt)
    local E = 0  --Calculated_Errors()


    if training == true or step == true then
        for m = 1, (iterations_per_frame) do
            iterations = iterations + 1
            -- step 1: done in load function

            -- step 2: calculate actual outputs
            for i = 1, (#training_x) do
                o[i] = get_output(training_x[i])
            end

            E = Calculated_Errors()

            -- step 3 : calculate partial derivities and update W values
            for j = 1, (num_neurons) do
                change[j] = partial_deriv(j)
                w[j] = w[j] - learning_rate * change[j]
                graph2:update(j, get_output(training_x[j])) -- update graph
            end
        end

        step = false
        print("Iter: " .. iterations .. " Error: " .. E)
    end
end

function love.draw()
    graph:draw()
    graph2:draw()
end
