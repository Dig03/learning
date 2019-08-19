import json

fname = input("Enter file name: ")

print("Reading file... ", end='')
with open(fname, 'r') as f:
    content = f.read().lower()
print("done")

print("Splitting lines... ", end='')
lines = content.split()
print("done")

words = []

print("Determining unique words... ", end='')
for line in lines:
    line = line.split()
    for word in line:
        if word.isalpha():
            words.append(word)
print("done")

words = set(words)

progress = 0
display_length = 0
total = len(words)
concordance = {}
for word in words:
    progress_percent = progress/total * 100
    display = "{:.2f}% ({}/{}) '{}'".format(progress_percent, progress, total, word)
    display += ' ' * (display_length - len(display))

    display_length = len(display)
    print(display, end='')
    concordance[word] = content.count(word)
    print(end='\r')
    progress += 1

with open("{}.json".format(fname), 'w') as f:
    json.dump(concordance, f)

print("Results saved to {}.json".format(fname))

