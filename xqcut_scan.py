import csv
import matplotlib.pyplot as plt

x_rhadron = []
y_rhadron = []

x_stop_1400 = []
y_stop_1400 = []

x_stop_525 = []
y_stop_525 = []

# Read data from CSV 
with open('xqcut_scan.csv', newline='') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)  # skip header
    for row in reader:
        qcut = float(row[0])
        accepted = float(row[1])
        efficiency = (accepted / 1000) * 100  # convert accepted events to efficiency in %
        source = row[2].strip()
        if source == 'mg-Rhadron_mGl-1800':
            x_rhadron.append(qcut)
            y_rhadron.append(efficiency)
        elif source == 'StopStop_mStop-1400':
            x_stop_1400.append(qcut)
            y_stop_1400.append(efficiency)
        elif source == 'StopStop_mStop-525':
            x_stop_525.append(qcut)
            y_stop_525.append(efficiency)

plt.figure(figsize=(8, 6))
plt.plot(x_rhadron, y_rhadron, marker='o', linestyle='None', color='b', label='mg-Rhadron_mGl-1800')
plt.plot(x_stop_1400, y_stop_1400, marker='s', linestyle='None', color='orange', label='SMS-StopStop_mStop-1400')
plt.plot(x_stop_525, y_stop_525, marker='^', linestyle='None', color='green', label='SMS-StopStop_mStop-525')

all_x = x_rhadron + x_stop_1400 + x_stop_525

plt.xticks(range(int(min(all_x)//50) * 50, int(max(all_x)//50 + 1) * 50, 50))
plt.yticks(range(0, 101, 10))

plt.xlabel('xqcut (GeV)')
plt.ylabel('Pythia Matching Efficiency (%)')
plt.title('Efficiency of Accepted Pythia Events')
plt.grid(True)
plt.legend(bbox_to_anchor=(0.5, 0.2), loc='center left')
plt.tight_layout()
plt.savefig('xqcut_scan_plot.png')