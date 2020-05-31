import csv

with open('FullData.txt').readlines()[1:20] as file:
    csv_reader = csv.reader(file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(csv_reader[line_count])}')
            line_count += 1
        else:
            print(csv_reader[line_count])
            line_count += 1
    print("Done")
