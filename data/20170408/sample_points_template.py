import random
# import sys, getopt

# print 'Number of arguments:', len(sys.argv)
# print 'Argument List:', str(sys.argv)



l2 = [] 
l = 

#-------- cut -----
# insert data here
#-------- cut ------

# random.seed(783942)

l2 = [] 
for n in range(0,100):
	idx = random.randrange(0,len(l))
	l2 += [l[idx]]

print "3" # print the dimension of the data
for p in l2:
	az, range, vel = p
	print az, range, vel
