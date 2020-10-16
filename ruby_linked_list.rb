#the class that is the filling of the linked list
class Node 
  attr_accessor :next_node, :data

#@next_node is what points to the next node on the list. and because it will always end with nil it equals nil by default. Data also equals nil by default so you don't have to put anything when creating a new instance of the class.
  def initialize(data=nil)
    @next_node = nil
    @data = data
  end

#checks to see if the current node is the tail or the one that equals nil  
  def tail?
    @next_node.nil?
  end

end

#the main class where most of the work is done. inherits from Node so that it can acsess @next_node and @data.
class LinkedList < Node
  attr_accessor :head
 
#this method creates the head for the list which by defualt equals nothing so the starting list is blank. 
def initialize(head = nil)
    @head = head
  end

#allows you to create a new node by calling upon the Node class. Mostly used in conjunction with other methods.  
def new_node(element)
    Node.new(element)
  end

#Until you get to the end of the list it counts nodes and returns how many at the end.  
def count_node(node, counter)
  until node.tail?
    node = node.next_node
    counter += 1
  end
counter
end

#allows calls upon the new_node method to create a new list entry. This new entry pushes the previous head in front of it making it the new head.
def prepend(entry)
    node = new_node(entry)
    node.next_node = head
    @head = node
  end

#similer to prepend but ituses set_tail/set_head based on the existing list. if it is not empty you add the value to the end. if it is empty you make the value the head.
def append(value)
  if !empty?
    set_tail(value)
  else
    set_head(value)
  end
end 

#uses at_no _data(which is good for pinpointing index loactions of nodes) and removes a node at the given index. The node previously after the removed node is put in the removed nodes spot. the user is told what was removed and it returns the rmoved node.
def remove_at(index)
    removed_node = at_no_data(index)
    prev_node = at_no_data(index - 1)
    next_node = at_no_data(index + 1)
    prev_node.next_node = next_node
    puts "#{removed_node.data} has left the group"
    removed_node
  end

#returns true if the head equals nil because that means the list is empty.  
def empty?
  head.nil?
end

#allows you to set a new head value by using new_node
def set_head(value)
 @head = new_node(value)
end

#allows you to set a tail value by using last_node(which finds the tail) and puts your value after it.
def set_tail(value)
last_node(head).next_node = new_node(value)
    end

#removes the previous tail and makes the second to last value the tail. Size shows how many elements are in the list and it is being subtracted by two because indexing starts with 0 but size starts with one.    
def pop
 new_tail = at(size - 2)
 old_tail = tail
 puts "#{old_tail.data} is now gone!"
 set_tail(new_tail)
 old_tail = nil
 old_tail
end

#uses count node to count how many nodes are in the list it starts at the head which is one and goes up.
def size
  return 0 if empty?
 count_node(head, 1)
end

#counts how long it takes to reach a specific node. regresses until either you get to the node or you get to the tail
def count_node(node, counter)
  return counter if node.tail?
  count_node(node.next_node, counter += 1)
end

#returns the head value but gives nil if the list is empty.
def get_head
  return nil if @head.nil?
node = @head
node.data
end 

#gives the data for a node at a given index. Will work as many times as their is nodes or until you reach the index you want.
def at(index)
    node = @head
    count = 0
    size.times do
      break if index == count
      node = node.next_node
      count += 1
    end
    return node.data
  end

 #like the at method but it returns the node number of what you want. Works well with other methods like remove_at and insert_at. 
  def at_no_data(index)
    node = @head
    count = 0
    size.times do
      break if index == count
      node = node.next_node
      count += 1
    end
    return node
  end

#checks to see if a certain value is included in the list. if it is you get true if not false. works until the list ends or you the nodes data equals the value selected.
def contains?(value)
  return false if @head.nil?
  node = @head
  limit = size - 1
  limit.times do
    break if node.data == value
    node = node.next_node
  end
  if value == node.data 
    true
  else
    false
  end
end

#locates the index value of a given value. Will tell you if the value is not included or if your list is blank.
def find(value)
  return nil if @head.nil?
  i = 0
  node = @head
  limit = size - 1
  limit.times do
  break if node.data == value
    i += 1
    node = node.next_node
  end 
if node.data == value
 "#{value} is located in index number #{i}."
 i
else 
  puts "the given value is not on the list."
end
end

#returns a string version of the list. It works until you reach the tail and will then add "nil" to the end to finish the list.
def to_s 
  return nil if @head.nil?
 node = @head
  final_string = "(#{node.data}) -> "
  until node.tail? do
    final_string += "(#{node.next_node.data}) -> "
    node = node.next_node 
  end
  final_string += "nil"
  final_string
end

#returns the value of the last node. Works recursively till list has been combed over.
def last_node(node)
  return node if tail?
  last_node(node.next_node)
  end

#returns the last node in the list by using last node and your head node.
def tail
  last_node(head)
end

#EXTRA CREDIT
#lets you insert a data point into the list at a chosen index. Only works if index is a valid index in the list and that the lsit is not empty. The data point is inserted and the node that was previously before the replaced node now points to the newly added node which points to what it replaced. 
def insert_at(value, index)
  length = size - 1
  if @head.nil?
    set_head(value)
  elsif index > length
    puts "the list does not have a value associated with your given index."
  else
    old_node = at_no_data(index)
    old_next_node = at_no_data(index + 1)
    prev_node = at_no_data(index - 1)
    prev_node.next_node.data = value
    prev_node.next_node = old_node
  end
end

end



list_test = LinkedList.new
list_test.set_head('paul')
list_test.append('seven')
list_test.prepend('six')
list_test.prepend('two')



puts list_test.to_s
# => (two) -> (six) -> (paul) -> (seven) -> nil

puts list_test.find('seven')
# => 3
puts list_test.contains?('ten')
# => false
puts list_test.contains?('two')
# => true

puts list_test.get_head
# => two

puts list_test.at(2)
# = > paul

list_test.insert_at('one',1)

list_test.remove_at(2)
# => paul has left the group

puts list_test.to_s
# => (two) -> (one) -> (seven) -> nil