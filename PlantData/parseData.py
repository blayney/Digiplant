import csv, itertools
allCommonNames = []
nameSet = set()
with open('FullData.txt') as file:
    csv_reader = csv.reader(file, delimiter=',')
    line_count = 0
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        elif row[3] != '':
            if row[3] not in nameSet:
                allCommonNames.append(row[3])
                line_count += 1
            nameSet.add(row[3])
    print("Done")
    print("Number of common names = {}".format(line_count))

    with open('UniqueNames.txt', mode='w') as file:
        writer = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

        writer.writerow(allCommonNames)
    print("Done")
