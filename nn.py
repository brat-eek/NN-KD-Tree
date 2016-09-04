from collections import namedtuple
from operator import itemgetter
from pprint import pformat
import tensorflow as tf
import numpy as np

currnode=(0,0)    #remember to change these if you change dimension
currbest=(100,100)
flag=0
cnt=0

class Node():
	def __init__(self, location, left_child, right_child):
		self.location = location
		self.left_child = left_child
		self.right_child = right_child


def kdtree(point_list, depth=0):
	try:
		k = len(point_list[0]) 
	except IndexError as e: 
		return None
	
	axis = depth % k
 	
	point_list.sort(key=itemgetter(axis))
	median = len(point_list) // 2 # get median
 
	return Node(
		location=point_list[median],
		left_child=kdtree(point_list[:median], depth + 1),
		right_child=kdtree(point_list[median + 1:], depth + 1)
	)

def dist(a,b):
	global currbest
	global currnode
	d=0
	num = len(a)
	for i in xrange(num):
		d = d + (a[i]-b[i])**2
	return d


def pri(tree):
	if(tree==None):
		return 
	print(tree.location),
	print('('),
	tree.left_child=pri(tree.left_child)
	print(')'),
	print('{'),
	tree.right_child=pri(tree.right_child)
	return tree
	print('}') 


def addnn(tree, query, depth, k):
	global currnode
	global currbest
	global flag
	global cnt

	if(tree==None):
		print('Reached end')
		if(cnt==0):
			cnt=1;
			return Node(location=query,
				left_child=None,
				right_child=None)
		else:
			return tree
	#pri(tree)
	axis = depth % k
	
	if(query[axis] < tree.location[axis]):
		print('from ',tree.location,)
		print(' left child is called ')
		#print(tree.left_child.location)
		tree.left_child = addnn(tree.left_child, query, depth+1, k)
		flag=0
	else:
		print('from ',tree.location,)
		print(' right child is called ')
		#print(tree.left_child.location)
		tree.right_child = addnn(tree.right_child, query, depth+1, k)
		flag=1

	currnode = tree.location
	d1 = dist(currbest, query)	#radius of hypersphere
	d2 = dist(currnode, query)  #query point to hyperplane defined by the current node
	if(d2 < d1):
		currbest = currnode
	print('best now: ',currbest)
	radius = dist(currbest, query)
	hyper = abs(query[axis] - currnode[axis])
	if(radius>hyper):
		if(flag==0):
			tree.right_child = addnn(tree.right_child, query, depth+1, k)
		else:
			tree.left_child = addnn(tree.left_child, query, depth+1, k)
	return tree

def main():
	"""Example usage"""
	point_list = [(2,3), (3,6), (5,4), (9,6), (4,6), (4,7), (8,1), (7,2)]
	tree = kdtree(point_list)
	tree=pri(tree)
	#tree=pri(tree)
	print('Add Point to test: ')
	query = tuple(int(x.strip()) for x in raw_input().split(','))
	tree = addnn(tree, query, 0, len(query))
	pri(tree)
	print('jhingalala ho hoo ho')
	print(currbest)

if __name__ == '__main__':
	main()











