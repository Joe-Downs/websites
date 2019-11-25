import csv
csv_filepath = "/home/joe/git/gogobe.be/ranking/csv-test.csv"
list0 = []
list1 = []
list2 = []
list3 = []
with open(csv_filepath, newline="") as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        #print(row["coolvalues"], row["coolvalue1"], row["coolvalue2"], row["coolvalue3"])
        list0.append(row["coolvalues"])
        list1.append(row["coolvalue1"])
        list2.append(row["coolvalue2"])
        list3.append(row["coolvalue3"])
print(list0)
print(list1)
print(list2)
print(list3)
        
for value in list0:
    print(value)
