--[[ First attempt at a stack and queue oriented SLL in Lua ]]

--[[ TODO: Write contains() method ]]

--[[ Define the Node object ]]

Node = {}
Node.__index = Node

function Node:new(data)
    local obj = {
        data = data,
        nxt = nil
    }
    setmetatable(obj, self)
    return obj
end


--[[ Define the LinkedList object ]]

LinkedList = {}
LinkedList.__index = LinkedList

function LinkedList:new()
    local obj = {
        head = nil,
        tail = nil,
        length = 0
    }
    setmetatable(obj, self)
    return obj
end

function LinkedList:push(data)
    local new_node = Node:new(data)
    new_node.nxt = self.head  -- this still works even if it is the first thing b/c self.head is nil
    if self.length == 0 then
        self.tail = new_node
    end
    self.head = new_node
    self.length = self.length + 1
end

function LinkedList:pop()
    if self.head == nil then
        return nil, 'List is empty, nothing to pop.'
    else
        local data_to_return = self.head.data
        if self.tail == self.head then
            self.tail = nil
        end
        self.head = self.head.nxt
        self.length = self.length - 1
        return data_to_return
    end
end

function LinkedList:enqueue(data)
    if self.length == 0 then
        self:push(data)
    else
        local new_node = Node:new(data)
        self.tail.nxt = new_node
        self.tail = new_node
        self.length = self.length + 1
    end
end

function LinkedList:dequeue()
    -- We dequeue from the front, because it is the fastest operation
    return self:pop()
end

function LinkedList:get_length()
    return self.length
end

function LinkedList:peek()
    if self.length == 0 then
        return nil, 'List is empty!'
    else
        return self.head.data
    end
end

function LinkedList:peek_tail()
    if self.length == 0 then
        return nil, 'List is empty!'
    else
        return self.tail.data
    end
end

function LinkedList:get(index)
    if self.head == nil then
        return nil, 'List is empty.'
    elseif index == 1 or index == nil then
        return self:peek()
    elseif index == self.length then
        return self:peek_tail()
    elseif index < 1 then
        return nil, 'Invalid index. Index must be > 0.'
    else
        -- traverse the list
        local count = 1
        local current_node = self.head
        while count < index and current_node ~= nil do  -- replace with a length check?
            count = count + 1
            current_node = current_node.nxt
        end
        if current_node == nil then  -- replace with a length check?
            return nil, "Index out of range."
        else
            return current_node.data
        end
    end
end

function LinkedList:contains(value)
    if self.head == nil then
        return nil, 'List is empty.'
	end
	-- traverse the list
	local current_node = self.head
	while current_node ~= nil do
		if current_node.data == value then return true end
		--[[ TODO: Add checking for table equality ]]
		current_node = current_node.nxt
	end
	return false
end

function LinkedList:print()
	if self.head == nil then
		return nil, 'List is empty.'
	end
	--traverse the list and print each value
	local current_node = self.head
	while current_node ~= nil do
		print(current_node.data)
		current_node = current_node.nxt
	end
	return true
end

function LinkedList:reversed()
	if self.head == nil then
		return nil, 'List is empty.'
	end
	local tmp = LinkedList:new()
	local current_node = self.head
	while current_node ~= nil do
		tmp:push(current_node.data)
		current_node = current_node.nxt
	end
	return tmp
end

return LinkedList
