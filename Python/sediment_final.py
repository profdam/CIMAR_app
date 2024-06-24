{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "ad9fc85e-a915-4c1e-991f-040f93d19c6c",
   "metadata": {},
   "outputs": [],
   "source": [
    "import numpy as np\n",
    "import sediment_transport_utils as stu\n",
    "\n",
    "# Load the .mat files\n",
    "data_filepath = 'ensemble_data.mat'\n",
    "coastline_filepath = 'coastline_direction_uniform.mat'\n",
    "data = stu.load_data(data_filepath)\n",
    "coastline_data = stu.load_data(coastline_filepath)\n",
    "\n",
    "# Extract data\n",
    "tm_a, hs_a, dm_a, tm_s, hs_s, dm_s, tm_w, hs_w, dm_w, lon_f, lat_f, coastlineDirection = stu.extract_data(data, coastline_data)\n",
    "\n",
    "# Calculate normal to coastline\n",
    "normalToCoastline = stu.calculate_normal_to_coastline(coastlineDirection)\n",
    "\n",
    "# Calculate directions relative to the north for wave direction (annual average)\n",
    "waveDirRelToNorth_a, waveDirRelToNorth_s, waveDirRelToNorth_w = stu.calculate_wave_directions(normalToCoastline, dm_a, dm_s, dm_w)\n",
    "\n",
    "# Calculate longshore sediment transport (annual average)\n",
    "Thetab_a, Hb_a, hb_a, R_a, S_a, V_a = stu.calculate_sediment_transport(tm_a, hs_a, waveDirRelToNorth_a, lon_f)\n",
    "Thetab_s, Hb_s, hb_s, R_s, S_s, V_s = stu.calculate_sediment_transport(tm_s, hs_s, waveDirRelToNorth_s, lon_f)\n",
    "Thetab_w, Hb_w, hb_w, R_w, S_w, V_w = stu.calculate_sediment_transport(tm_w, hs_w, waveDirRelToNorth_w, lon_f)\n",
    "\n",
    "# Calculate omega and transport\n",
    "OMEGA_a, OMEGA_s, OMEGA_w = stu.calculate_omega(Hb_a, V_a, Hb_s, V_s, Hb_w, V_w)\n",
    "TRANSPORT_a, TRANSPORT_s, TRANSPORT_w = stu.calculate_transport(OMEGA_a, OMEGA_s, OMEGA_w)\n",
    "\n",
    "# Convert transport to per year\n",
    "conversionFactor = 1 / 31536000\n",
    "Q_hist_a = TRANSPORT_a / conversionFactor\n",
    "Q_hist_s = TRANSPORT_s / conversionFactor\n",
    "Q_hist_w = TRANSPORT_w / conversionFactor\n",
    "\n",
    "V_hist_a = V_a\n",
    "V_hist_s = V_s\n",
    "V_hist_w = V_w\n",
    "\n",
    "# Display results\n",
    "print(\"Q_hist_a:\", Q_hist_a)\n",
    "print(\"Q_hist_s:\", Q_hist_s)\n",
    "print(\"Q_hist_w:\", Q_hist_w)\n",
    "print(\"V_hist_a:\", V_hist_a)\n",
    "print(\"V_hist_s:\", V_hist_s)\n",
    "print(\"V_hist_w:\", V_hist_w)\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.7"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
