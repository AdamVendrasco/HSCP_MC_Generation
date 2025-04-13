#!/usr/bin/env python
import ROOT
import matplotlib.pyplot as plt
import numpy as np
import os
import matplotlib.colors as colors
from matplotlib.ticker import ScalarFormatter
from mpl_toolkits.mplot3d import Axes3D
# Open the ROOT file and get the tree
filename = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/root-files/mg-Rhadron_mGl-1800-CMSSW_13_2_9-n1000-Jet_matching_ON-100.root"
work_dir = "/eos/user/a/avendras/mg-Rhadron_v6/mg-Rhadron_mGl-1800/plots/"
file = ROOT.TFile.Open(filename)
if not file or file.IsZombie():
    raise Exception("Could not open file: " + filename)

tree = file.Get("Events")
if not tree:
    raise Exception("Could not retrieve the TTree 'Events'.")

nEvents = tree.GetEntries()

rhadron_gen_pt      = []
rhadron_gen_charge  = []
rhadron_gen_pdgid   = []
rhadron_gen_eta     = []
rhadron_gen_phi     = []
rhadron_gen_mass    = []
rhadron_gen_status  = []

rhadron_count = 0
gen_particle_count = 0

for event_index in range(nEvents):
    tree.GetEntry(event_index)
    gen_particles_wrapper = getattr(tree, "recoGenParticles_genParticles__GEN.", None)
    if not gen_particles_wrapper:
        continue
    gen_particles = gen_particles_wrapper.product()
    if event_index % 100 == 0:
        print(f"Event {event_index} has {gen_particles.size()} gen particles")
    for j in range(gen_particles.size()):
        gen = gen_particles.at(j)
        gen_particle_count += 1
        if 1000600 <= abs(gen.pdgId()) <= 1100000 and gen.status() == 1:
            rhadron_count += 1
            rhadron_gen_pt.append(gen.pt())
            rhadron_gen_eta.append(gen.eta())
            rhadron_gen_phi.append(gen.phi())
            rhadron_gen_mass.append(gen.mass())
            rhadron_gen_charge.append(gen.charge())
            rhadron_gen_status.append(gen.status())
            rhadron_gen_pdgid.append(gen.pdgId())

print("-------------------------------------------")
print("")
print(f"Total gen_particle_count: {gen_particle_count}")
print(f"Total Rhadron_count: {rhadron_count}")
print("")
print("-------------------------------------------")

rhadron_gen_pdgid = np.array(rhadron_gen_pdgid)
unique_pdgids, counts = np.unique(rhadron_gen_pdgid,return_counts=True)
most_common_index = np.argmax(counts)
most_common_pdgid = unique_pdgids[most_common_index]
most_common_count = counts[most_common_index]

rhadron_gen_mass = np.array(rhadron_gen_mass)
unique_mass = np.unique(rhadron_gen_mass)

rhadron_gen_charge = np.array(rhadron_gen_charge)
unique_charge = np.unique(rhadron_gen_charge)

rhadron_gen_status = np.array(rhadron_gen_status)
unique_status = np.unique(rhadron_gen_status)


print("")
print("Unique rhadron PDG IDs:", unique_pdgids)
print("Number of unique rhadron PDG IDs:", len(unique_pdgids))
print("")

print("-------------------------------------------")
print("")
print("The most common pdgid is:", most_common_pdgid, "with a count of ", most_common_count)
print("")

print("-------------------------------------------")
print("")
print("Unique rhadron mass:", unique_mass)
print("Number of unique rhadron mass values:", len(unique_mass))
print("")

print("-------------------------------------------")
print("")
print("Unique rhadron charge:", unique_charge)
print("Number of unique rhadron charge values:", len(unique_charge))
print("")

print("-------------------------------------------")
print("")
print("Unique rhadron Status code:", unique_status)
print("Number of unique rhadron Status code:", len(unique_status))
print("")

print("-------------------------------------------")
print("")
print("rhadron eta min and max:", np.min(rhadron_gen_eta), np.max(rhadron_gen_eta))
print("")

print("-------------------------------------------")
print("")
print("rhadron phi min and max:", np.min(rhadron_gen_phi), np.max(rhadron_gen_phi))
print("")




bins = np.linspace(rhadron_gen_pdgid.min(), rhadron_gen_pdgid.max(), num=100)
x_min = -1096000 
x_max = 1093600  
plt.figure(figsize=(12, 6))
plt.hist(rhadron_gen_pdgid, bins=bins, color='skyblue', edgecolor='black', label='PDG ID')
plt.ylabel("Counts")

plt.xlabel("PDGID")
plt.title("RHadrons: PDGID Distribution")
plt.ticklabel_format(style='plain', axis='x')
custom_xticks = np.linspace(x_min, x_max, num=25)
plt.xticks(custom_xticks, rotation=45)
plt.xlim(x_min, x_max)
plt.xticks(rotation=45)
plt.grid(True, linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_pdgid_histogram.pdf"))

plt.clf()
plt.style.use('ggplot')
plt.figure(figsize=(10, 6))
bins_x = np.linspace(rhadron_gen_pdgid.min(), rhadron_gen_pdgid.max(), 40)
bins_y = np.linspace(1800, 1802, 40)
h = plt.hist2d(rhadron_gen_pdgid, rhadron_gen_mass, bins=[bins_x, bins_y],cmap='copper',norm=colors.LogNorm())
plt.xlabel("PDG ID")
plt.ylabel("Mass (GeV)")
plt.title("RHadrons: 2D Distribution of Mass vs PDG ID")
plt.colorbar(h[3], label='Counts') 
plt.grid(True)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_mass_vs_pdgid_2d.pdf"))


bins_x = np.linspace(rhadron_gen_pdgid.min(), rhadron_gen_pdgid.max(), 50)
bins_y = np.linspace(1798, 1802, 40)
hist, xedges, yedges = np.histogram2d(rhadron_gen_pdgid, rhadron_gen_mass, bins=[bins_x, bins_y])
xpos, ypos = np.meshgrid(xedges[:-1] + np.diff(xedges) / 2,
                         yedges[:-1] + np.diff(yedges) / 2,
                         indexing="ij")
xpos = xpos.ravel()
ypos = ypos.ravel()
zpos = np.zeros_like(xpos)
dx = np.diff(xedges)[0] * np.ones_like(zpos)
dy = np.diff(yedges)[0] * np.ones_like(ypos)
dz = hist.ravel()
norm = colors.LogNorm(vmin=dz[dz > 0].min() if np.any(dz > 0) else 1, vmax=dz.max())
cmap = plt.cm.copper
bar_colors = cmap(norm(dz))
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111, projection='3d')
ax.bar3d(xpos, ypos, zpos, dx, dy, dz, color=bar_colors, shade=True)

ax.set_xlabel("PDG ID")
ax.set_ylabel("Mass (GeV)")
ax.set_zlabel("Counts")
ax.set_title("RHadrons: 3D Histogram of Mass vs PDG ID")
x_tick_positions = np.linspace(rhadron_gen_pdgid.min(), rhadron_gen_pdgid.max(), num=5)
ax.set_xticks(x_tick_positions)
x_tick_labels = [f"{int(x)}" for x in x_tick_positions]
ax.set_xticklabels(x_tick_labels)
y_tick_positions = np.linspace(1798, 1802, num=5)
ax.set_yticks(y_tick_positions)
y_tick_labels = [f"{y:.1f}" for y in y_tick_positions]
ax.set_yticklabels(y_tick_labels)
mappable = plt.cm.ScalarMappable(norm=norm, cmap=cmap)
mappable.set_array(dz)
cbar = plt.colorbar(mappable, ax=ax, pad=0.1)
cbar.set_label('Counts')
plt.tight_layout()
plt.savefig(os.path.join(work_dir, "Rhadron_mass_vs_pdgid_3d_custom_ticks.pdf"))


plt.clf()
plt.figure(figsize=(10, 6))
bins_charge = np.linspace(np.min(rhadron_gen_charge), np.max(rhadron_gen_charge), num=50)
plt.hist(rhadron_gen_charge, bins=bins_charge, color='skyblue', edgecolor='black', label='Charge')
plt.ylabel("Counts")
plt.xlabel("Charge")
plt.title("RHadrons: Charge")
plt.xticks(rotation=90)
plt.grid(True, linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_charge_histogram.pdf"))


plt.clf()
plt.figure(figsize=(10, 6))
bins_charge = np.linspace(np.min(rhadron_gen_pt), np.max(rhadron_gen_pt), num=40)
plt.hist(rhadron_gen_pt, bins=bins_charge, color='skyblue', edgecolor='black', label='pT')
plt.ylabel("Counts")
plt.xlabel("pT (GeV)")
plt.title("RHadrons: pT")
plt.xticks(rotation=90)
plt.grid(True, linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_pT_histogram.pdf"))

plt.clf()
plt.figure(figsize=(10, 6))
bins_charge = np.linspace(np.min(rhadron_gen_eta), np.max(rhadron_gen_eta), num=35)
plt.hist(rhadron_gen_eta, bins=bins_charge, color='skyblue', edgecolor='black', label='eta')
plt.ylabel("Counts")
plt.xlabel("Eta")
plt.title("RHadrons: Eta")
plt.xticks(rotation=90)
plt.grid(True, linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_eta_histogram.pdf"))

plt.clf()
plt.figure(figsize=(10, 6))
bins_charge = np.linspace(np.min(rhadron_gen_phi), np.max(rhadron_gen_phi), num=35)
plt.hist(rhadron_gen_phi, bins=bins_charge, color='skyblue', edgecolor='black', label='phi')
plt.ylabel("Counts")
plt.xlabel("Phi")
plt.title("RHadrons: Phi")
plt.xticks(rotation=90)
plt.grid(True, linestyle='--', alpha=0.7)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_phi_histogram.pdf"))

plt.clf()
plt.style.use('ggplot')
plt.figure(figsize=(10, 6))
bins_x = np.linspace(rhadron_gen_charge.min(), rhadron_gen_charge.max(), 40)
bins_y = np.linspace(rhadron_gen_pdgid.min(), rhadron_gen_pdgid.max(), 40)
h = plt.hist2d(rhadron_gen_charge, rhadron_gen_pdgid, bins=[bins_x, bins_y],cmap='copper',norm=colors.LogNorm())
plt.xlabel("Charge")
plt.ylabel("PDG ID ")
plt.title("RHadrons: 2D Distribution of Charge vs PDG ID")
plt.colorbar(h[3], label='Counts') 
plt.grid(True)
plt.tight_layout()
plt.savefig(os.path.join(work_dir,"Rhadron_pdgid_vs_charge.pdf"))

plt.clf()
plt.figure(figsize=(10, 6))
bins_charge = np.linspace(np.min(rhadron_gen_mass), np.max(rhadron_gen_mass), num=30)
plt.hist(rhadron_gen_mass, bins=bins_charge, color='skyblue', edgecolor='black', label='mass')
plt.ylabel("Counts")
plt.xlabel("Mass (GeV)")
plt.title("RHadrons: Mass Distribution")
xticks = np.linspace(np.min(rhadron_gen_mass), np.max(rhadron_gen_mass), num=15)
plt.xticks(xticks, rotation=45)
plt.grid(True, linestyle='--', alpha=0.7)
plt.savefig(os.path.join(work_dir, "Rhadron_mass_histogram.pdf"))
