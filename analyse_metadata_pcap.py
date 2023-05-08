#!./venv/bin/python3

# Date - 06 May 2023
# Author - Joydeep Pal
# Description - Analyse pcap-json-csv file which has raw packet data to find metadata
# at specific positions and analyse time difference of our two TSN switches.

import datetime
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

Plotting = "Subplots"  # "Separate"
flierprops = dict(marker='o', markersize=1)  # Define outlier properties of boxplots
sns.set_theme(style='white', context='poster',
              font_scale=0.75, rc={'figure.figsize': (16, 9)})

FileDate = datetime.datetime.now().strftime("%Y_%m_%d_%H_%M_%S")

df = pd.read_csv('pcap/sample_json_text_from_pcap.csv', names=('frame_raw', 'a', 'b', 'c', 'd'))
# Build index as another column for convenient handling of plotting functions
df['Time'] = df.index
# Clean data
df['frame_raw'] = df['frame_raw'].str.replace("[", "",regex=True)
# Extract hex of your Metadata Header
df['sw1_ME_ts_counter_raw'] = df['frame_raw'].str[37:53]
df['sw2_ME_ts_counter_raw'] = df['frame_raw'].str[69:85]
# Convert hex string to int
df['sw1_ME_ts_counter'] = df['sw1_ME_ts_counter_raw'].apply(lambda u: int(u, 16))
df['sw2_ME_ts_counter'] = df['sw2_ME_ts_counter_raw'].apply(lambda u: int(u, 16))
# Difference between counter value
df['counter_diff'] = df['sw2_ME_ts_counter'] - df['sw1_ME_ts_counter']
# Conversion from counter to timestamp (in nanoseconds) for 633 MHz ME freq
conv_value = 16000/633
df['sw1_ME_ts'] = df['sw1_ME_ts_counter'] * conv_value
df['sw2_ME_ts'] = df['sw2_ME_ts_counter'] * conv_value
# Difference between timestamps value
df['Sync error (in ns)'] = df['sw2_ME_ts'] - df['sw1_ME_ts']

# Converison variable for milliseconds
ns_to_ms = 10**(-6)
# Difference between consecutive sw1_ME_ts values (jitter (in ms) of sw1_ME_ts with time)
df['jitter (in ms) of sw1_ME_ts']= (df['sw1_ME_ts']*(milsec_value)).diff()
#Difference between consecutive sw2_ME_ts values
df['jitter (in ms) of sw2_ME_ts']= (df['sw2_ME_ts']*(milsec_value)).diff()

if Plotting == "Subplots":

    fig, axes = plt.subplots(3,1, sharex='col', tight_layout=True,figsize=(9,5))
    # Plot time difference
    # sns.scatterplot(ax=axes[0, 1], data=df, y='ts_diff',
    #                 palette='dark').set_title('Synchronisation error (in ns) with time')
    # sns.scatterplot(data=df, x='Time', y='ts_diff', s=5,
    #                 palette='dark').set_title('Synchronisation error (in ns) with time')
    sns.set(font_scale=1)
    sns.scatterplot(ax=axes[0],data=df, x='Time', y='Synchronisation error (in ns) with time', s=12).set_title("Synchronisation error (in ns) with time")
    sns.scatterplot(ax=axes[1],data=df, x='Time', y='jitter (in ms) of sw1_ME_ts with time', s=12).set_title("Jitter in ts1  with time")
    sns.scatterplot(ax=axes[2],data=df, x='Time', y='jitter (in ms) of sw2_ME_ts with time', s=12).set_title("Jitter in ts2 with time")
    sns.set(font_scale=0.5)
    axes[0].set_ylabel("Synchronisation error (in ns) ",fontsize=15)
    axes[1].set_ylabel("jitter (in ms) of sw1_ME_ts ", fontsize=15)
    axes[2].set_ylabel("jitter (in ms) of sw2_ME_ts", fontsize=15)
    plt.show()
