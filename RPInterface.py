import paramiko
import tkinter as tk
import sys


off_state = 0


def off_command():
    global off_state
    if off_state == 0:
        update_command()
        off_button.configure(bg="green", text="On")
        off_state = 1
        ssh.exec_command("cd /opt/redpitaya/bin ; ./monitor 0x40600000 0x1")
    else:
        off_button.configure(bg="red", text="Off")
        off_state = 0
        ssh.exec_command("cd /opt/redpitaya/bin ; ./monitor 0x40600000 0x0")


def save_command():
    update_command()
    sftp = ssh.open_sftp()
    f = sftp.open("/lock/mem.txt", "w")
    f.truncate(0)
    for parameter in param_list:
        f.write(parameter + "\n")
    f.close()
    print("Data Saved")


def update_command():
    global param_list
    param_list[0] = str(calibration_check_var.get())
    param_list[1] = ch1_in_offset_entry.get()
    param_list[2] = ch1_in_gain_entry.get()
    param_list[3] = ch2_in_offset_entry.get()
    param_list[4] = ch2_in_gain_entry.get()
    param_list[5] = ch1_out_offset_entry.get()
    param_list[6] = ch1_out_gain_entry.get()
    param_list[7] = ch2_out_offset_entry.get()
    param_list[8] = ch2_out_gain_entry.get()
    param_list[9] = gen1_lf_period_entry.get()
    param_list[10] = gen1_lf_phase_entry.get()
    param_list[11] = gen1_lf_amp_entry.get()
    param_list[12] = gen2_lf_period_entry.get()
    param_list[13] = gen2_lf_phase_entry.get()
    param_list[14] = gen2_lf_amp_entry.get()
    param_list[15] = gen1_hf_period_entry.get()
    param_list[16] = gen1_hf_phase_entry.get()
    param_list[17] = gen1_hf_amp_entry.get()
    param_list[18] = gen2_hf_period_entry.get()
    param_list[19] = gen2_hf_phase_entry.get()
    param_list[20] = gen2_hf_amp_entry.get()
    param_list[21] = lia_in_var.get()
    param_list[22] = lia_ref_var.get()
    param_list[23] = lia_cut_var.get()
    param_list[24] = lia_scale_entry.get()
    param_list[25] = pid_in_var.get()
    param_list[26] = pid_set_var.get()
    param_list[27] = pid_bus_set_entry.get()
    param_list[28] = pid_p_entry.get()
    param_list[29] = pid_i_entry.get()
    param_list[30] = pid_d_entry.get()
    param_list[31] = pid_max_entry.get()
    param_list[32] = pid_min_entry.get()
    param_list[33] = str(clamp1_check_var.get())
    param_list[34] = clamp1_max_entry.get()
    param_list[35] = clamp1_min_entry.get()
    param_list[36] = str(clamp2_check_var.get())
    param_list[37] = clamp2_max_entry.get()
    param_list[38] = clamp2_min_entry.get()
    param_list[39] = out1_var.get()
    param_list[40] = out1_bus_entry.get()
    param_list[41] = out2_var.get()
    param_list[42] = out2_bus_entry.get()
    param_list[43] = ramp_period_entry.get()
    param_list[44] = ramp_amp_entry.get()
    param_list[45] = op1_in_1_var.get()
    param_list[46] = op1_in_2_var.get()
    param_list[47] = op1_out_var.get()
    param_list[48] = op2_in_1_var.get()
    param_list[49] = op2_in_2_var.get()
    param_list[50] = op2_out_var.get()
    float_indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 24,
                     27, 28, 29, 30, 31, 32, 34, 33, 35, 36, 37, 38, 40, 42, 43, 44]
    int_indexes = [0, 9, 12, 15, 18, 33, 36, 43]
    entries = param_list.copy()
    try:
        for i in float_indexes:
            entries[i] = float(entries[i])
        for i in int_indexes:
            entries[i] = int(round(entries[i]))
        entries[1] = int(round((2 ** 13 - 1) * entries[1]))
        entries[2] = int(round((2 ** 12 - 1) * entries[2]))
        entries[3] = int(round((2 ** 13 - 1) * entries[3]))
        entries[4] = int(round((2 ** 12 - 1) * entries[4]))
        entries[5] = int(round((2 ** 13 - 1) * entries[5]))
        entries[6] = int(round((2 ** 12 - 1) * entries[6]))
        entries[7] = int(round((2 ** 13 - 1) * entries[7]))
        entries[8] = int(round((2 ** 12 - 1) * entries[8]))
        entries[10] = int(round((2 ** 1 - 1) * 2499 / 360 * entries[10]))
        entries[11] = int(round((2 ** 12 - 1) * entries[11]))
        entries[13] = int(round((2 ** 1 - 1) * 2499 / 360 * entries[13]))
        entries[14] = int(round((2 ** 12 - 1) * entries[14]))
        entries[16] = int(round((2 ** 1 - 1) * 123 / 360 * entries[16]))
        entries[17] = int(round((2 ** 12 - 1) * entries[17]))
        entries[19] = int(round((2 ** 1 - 1) * 123 / 360 * entries[19]))
        entries[20] = int(round((2 ** 12 - 1) * entries[20]))
        entries[24] = int(round((2 ** 12 - 1) * entries[24]))
        entries[27] = int(round((2 ** 13 - 1) * entries[27]))
        entries[28] = int(round((2 ** 13 - 1) * entries[28]))
        entries[29] = int(round((2 ** 39 - 1) * 1 / 125000000 * entries[29]))
        entries[30] = int(round((2 ** 1 - 1) * 125000 * entries[30]))
        entries[31] = int(round((2 ** 13 - 1) * entries[31]))
        entries[32] = int(round((2 ** 13 - 1) * entries[32]))
        entries[34] = int(round((2 ** 13 - 1) * entries[34]))
        entries[35] = int(round((2 ** 13 - 1) * entries[35]))
        entries[37] = int(round((2 ** 13 - 1) * entries[37]))
        entries[38] = int(round((2 ** 13 - 1) * entries[38]))
        entries[40] = int(round((2 ** 13 - 1) * entries[40]))
        entries[42] = int(round((2 ** 13 - 1) * entries[42]))
        entries[44] = int(round((2 ** 12 - 1) * entries[44]))
        entries[21] = lia_in_list.index(entries[21])
        entries[22] = lia_ref_list.index(entries[22])
        entries[23] = lia_cut_list.index(entries[23])
        entries[25] = pid_in_list.index(entries[25])
        entries[26] = pid_set_list.index(entries[26])
        entries[39] = out1_list.index(entries[39])
        entries[41] = out2_list.index(entries[41])
        entries[45] = op1_in_1_list.index(entries[45])
        entries[46] = op1_in_2_list.index(entries[46])
        entries[47] = op1_out_list.index(entries[47])
        entries[48] = op2_in_1_list.index(entries[48])
        entries[49] = op2_in_2_list.index(entries[49])
        entries[50] = op2_out_list.index(entries[50])
    except ValueError:
        print("Value Error.")
    hex_entries = []
    for i in range(51):
        hex_entries.append("")
    hex_entries[0] = hex(entries[0])
    hex_entries[1] = hex_convert(entries[1], 14)
    hex_entries[2] = hex_convert(entries[2], 16)
    hex_entries[3] = hex_convert(entries[3], 14)
    hex_entries[4] = hex_convert(entries[4], 16)
    hex_entries[5] = hex_convert(entries[5], 14)
    hex_entries[6] = hex_convert(entries[6], 16)
    hex_entries[7] = hex_convert(entries[7], 14)
    hex_entries[8] = hex_convert(entries[8], 16)
    hex_entries[9] = hex_convert(entries[9], 16)
    hex_entries[10] = hex_convert(entries[10], 12)
    hex_entries[11] = hex_convert(entries[11], 13)
    hex_entries[12] = hex_convert(entries[12], 16)
    hex_entries[13] = hex_convert(entries[13], 12)
    hex_entries[14] = hex_convert(entries[14], 13)
    hex_entries[15] = hex_convert(entries[15], 16)
    hex_entries[16] = hex_convert(entries[16], 7)
    hex_entries[17] = hex_convert(entries[17], 13)
    hex_entries[18] = hex_convert(entries[18], 16)
    hex_entries[19] = hex_convert(entries[19], 7)
    hex_entries[20] = hex_convert(entries[20], 13)
    hex_entries[21] = hex(entries[21])
    hex_entries[22] = hex(entries[22])
    hex_entries[23] = hex(5 + entries[23])
    hex_entries[24] = hex_convert(entries[24], 20)
    hex_entries[25] = hex(entries[25])
    hex_entries[26] = hex(entries[26])
    hex_entries[27] = hex_convert(entries[27], 14)
    hex_entries[28] = hex_convert(entries[28], 20)
    hex_entries[29] = hex_convert(entries[29], 20)
    hex_entries[30] = hex_convert(entries[30], 20)
    hex_entries[31] = hex_convert(entries[31], 14)
    hex_entries[32] = hex_convert(entries[32], 14)
    hex_entries[33] = hex(entries[33])
    hex_entries[34] = hex_convert(entries[34], 14)
    hex_entries[35] = hex_convert(entries[35], 14)
    hex_entries[36] = hex(entries[36])
    hex_entries[37] = hex_convert(entries[37], 14)
    hex_entries[38] = hex_convert(entries[38], 14)
    hex_entries[39] = hex(entries[39])
    hex_entries[40] = hex_convert(entries[40], 14)
    hex_entries[41] = hex(entries[41])
    hex_entries[42] = hex_convert(entries[42], 14)
    hex_entries[43] = hex_convert(entries[43], 16)
    hex_entries[44] = hex_convert(entries[44], 13)
    hex_entries[45] = hex(entries[45])
    hex_entries[46] = hex(entries[46])
    hex_entries[47] = hex(entries[47])
    hex_entries[48] = hex(entries[48])
    hex_entries[49] = hex(entries[49])
    hex_entries[50] = hex(entries[50])
    hex_order = {
        "0x40600004": 0,
        "0x40600008": 1,
        "0x4060000c": 2,
        "0x40600010": 0,
        "0x40600014": 3,
        "0x40600018": 4,
        "0x4060001c": 0,
        "0x40600020": 5,
        "0x40600024": 6,
        "0x40600028": 0,
        "0x4060002c": 7,
        "0x40600030": 8,
        "0x40600034": 9,
        "0x40600038": 10,
        "0x4060003c": 11,
        "0x40600040": 12,
        "0x40600044": 13,
        "0x40600048": 14,
        "0x4060004c": 15,
        "0x40600050": 16,
        "0x40600054": 17,
        "0x40600058": 18,
        "0x4060005c": 19,
        "0x40600060": 20,
        "0x40600064": 43,
        "0x40600068": 44,
        "0x4060006c": 23,
        "0x40600070": 24,
        "0x40600074": 28,
        "0x40600078": 29,
        "0x4060007c": 30,
        "0x40600080": 31,
        "0x40600084": 32,
        "0x40600088": 33,
        "0x4060008c": 34,
        "0x40600090": 35,
        "0x40600094": 36,
        "0x40600098": 37,
        "0x4060009c": 38,
        "0x406000a0": 21,
        "0x406000a4": 22,
        "0x406000a8": 25,
        "0x406000ac": 26,
        "0x406000b0": 45,
        "0x406000b4": 46,
        "0x406000b8": 48,
        "0x406000bc": 49,
        "0x406000c0": 47,
        "0x406000c4": 50,
        "0x406000c8": 39,
        "0x406000cc": 41,
        "0x406000d0": 27,
        "0x406000d4": 40,
        "0x406000d8": 42,
    }
    ssh_command = "cd /opt/redpitaya/bin "
    for x in range(1, 55):
        register = hex(4 * x)
        if len(register) < 4:
            register = "0x4060000" + register[2:]
        else:
            register = "0x406000" + register[2:]
        ssh_command += " ; ./monitor " + register + " " + hex_entries[hex_order[register]]
    ssh.exec_command(ssh_command)
    # Calculate Frequencies and Update Labels
    gen1_lf_freq_lbl.config(
        text=freq_calc(entries[9], 50000)
    )
    gen2_lf_freq_lbl.config(
        text=freq_calc(entries[12], 50000)
    )
    gen1_hf_freq_lbl.config(
        text=freq_calc(entries[15], 1000000)
    )
    gen2_hf_freq_lbl.config(
        text=freq_calc(entries[18], 1000000)
    )
    ramp_freq_lbl.config(
        text=freq_calc(entries[43], 50000)
    )


def freq_calc(period, max_frequency):
    frequency = max_frequency / (period + 1)
    if frequency < 1000:
        return ("%.3G" % frequency) + " Hz"
    elif frequency < 1000000:
        return ("%.3G" % (frequency / 1000)) + " kHz"
    else:
        return ("%.3G" % (frequency / 1000000)) + " MHz"


def hex_convert(int_input, bit_length):
    if int_input >= 0:
        return hex(int_input)
    else:
        return hex(2 ** bit_length + int_input - 1)


window = tk.Tk()
window.geometry("1200x800")
window.title("Red Pitaya Interface")

# Calibration Frame

calibration_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=315
)
calibration_frame.place(x=0, y=0)

calibration_title = tk.Label(
    text="Calibration"
)
calibration_title.place(x=85, y=10)

calibration_check_var = tk.IntVar()
calibration_enable_check = tk.Checkbutton(
    text="Enable",
    variable=calibration_check_var,
    onvalue=1,
    offvalue=0
)
calibration_enable_check.place(x=10, y=30)

ch1_in_lbl = tk.Label(
    text="Channel 1 In"
)
ch1_in_lbl.place(x=10, y=60)

ch1_in_offset_lbl = tk.Label(
    text="Offset"
)
ch1_in_offset_lbl.place(x=10, y=80)

ch1_in_offset_entry = tk.Entry(
    width=10,
)
ch1_in_offset_entry.place(x=12, y=100)

ch1_in_offset_unit = tk.Label(
    text="V"
)
ch1_in_offset_unit.place(x=77, y=100)

ch1_in_gain_lbl = tk.Label(
    text="Gain"
)
ch1_in_gain_lbl.place(x=10, y=120)

ch1_in_gain_entry = tk.Entry(
    width=10
)
ch1_in_gain_entry.place(x=12, y=140)

ch1_in_gain_unit = tk.Label(
    text="V/V"
)
ch1_in_gain_unit.place(x=77, y=140)

ch2_in_lbl = tk.Label(
    text="Channel 2 In"
)
ch2_in_lbl.place(x=10, y=170)

ch2_in_offset_lbl = tk.Label(
    text="Offset"
)
ch2_in_offset_lbl.place(x=10, y=190)

ch2_in_offset_entry = tk.Entry(
    width=10
)
ch2_in_offset_entry.place(x=12, y=210)

ch2_in_offset_unit = tk.Label(
    text="V"
)
ch2_in_offset_unit.place(x=77, y=210)

ch2_in_gain_lbl = tk.Label(
    text="Gain"
)
ch2_in_gain_lbl.place(x=10, y=230)

ch2_in_gain_entry = tk.Entry(
    width=10
)
ch2_in_gain_entry.place(x=12, y=250)

ch2_in_gain_unit = tk.Label(
    text="V/V"
)
ch2_in_gain_unit.place(x=77, y=250)

ch1_out_lbl = tk.Label(
    text="Channel 1 Out"
)
ch1_out_lbl.place(x=130, y=60)

ch1_out_offset_lbl = tk.Label(
    text="Offset"
)
ch1_out_offset_lbl.place(x=130, y=80)

ch1_out_offset_entry = tk.Entry(
    width=10
)
ch1_out_offset_entry.place(x=132, y=100)

ch1_out_offset_unit = tk.Label(
    text="V"
)
ch1_out_offset_unit.place(x=187, y=100)

ch1_out_gain_lbl = tk.Label(
    text="Gain"
)
ch1_out_gain_lbl.place(x=130, y=120)

ch1_out_gain_entry = tk.Entry(
    width=10
)
ch1_out_gain_entry.place(x=132, y=140)

ch1_out_gain_unit = tk.Label(
    text="V/V"
)
ch1_out_gain_unit.place(x=197, y=140)

ch2_out_lbl = tk.Label(
    text="Channel 2 Out"
)
ch2_out_lbl.place(x=130, y=170)

ch2_out_offset_lbl = tk.Label(
    text="Offset"
)
ch2_out_offset_lbl.place(x=130, y=190)

ch2_out_offset_entry = tk.Entry(
    width=10
)
ch2_out_offset_entry.place(x=132, y=210)

ch2_out_offset_unit = tk.Label(
    text="V"
)
ch2_out_offset_unit.place(x=197, y=210)

ch2_out_gain_lbl = tk.Label(
    text="Gain"
)
ch2_out_gain_lbl.place(x=130, y=230)

ch2_out_gain_entry = tk.Entry(
    width=10
)
ch2_out_gain_entry.place(x=132, y=250)

ch2_out_gain_unit = tk.Label(
    text="V/V"
)
ch2_out_gain_unit.place(x=197, y=250)

# Generators

gen_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=585
)
gen_frame.place(x=0, y=315)

gen_title = tk.Label(
    text="Sine Generators"
)
gen_title.place(x=70, y=325)

gen1_lf_lbl = tk.Label(
    text="Low Frequency\nGenerator 1"
)
gen1_lf_lbl.place(x=10, y=360)

gen1_lf_period_lbl = tk.Label(
    text="Period"
)
gen1_lf_period_lbl.place(x=10, y=395)

gen1_lf_period_entry = tk.Entry(
    width=10,
)
gen1_lf_period_entry.place(x=12, y=415)

gen1_lf_freq_lbl = tk.Label(
    text="0 kHz"
)
gen1_lf_freq_lbl.place(x=10, y=435)

gen1_lf_phase_lbl = tk.Label(
    text="Phase"
)
gen1_lf_phase_lbl.place(x=10, y=455)

gen1_lf_phase_entry = tk.Entry(
    width=10
)
gen1_lf_phase_entry.place(x=12, y=475)

gen1_lf_amp_lbl = tk.Label(
    text="Amplitude"
)
gen1_lf_amp_lbl.place(x=10, y=495)

gen1_lf_amp_entry = tk.Entry(
    width=10
)
gen1_lf_amp_entry.place(x=12, y=515)

gen1_lf_amp_unit = tk.Label(
    text="V"
)
gen1_lf_amp_unit.place(x=77, y=515)

gen2_lf_lbl = tk.Label(
    text="Low Frequency\nGenerator 2"
)
gen2_lf_lbl.place(x=10, y=575)

gen2_lf_period_lbl = tk.Label(
    text="Period"
)
gen2_lf_period_lbl.place(x=10, y=610)

gen2_lf_period_entry = tk.Entry(
    width=10,
)
gen2_lf_period_entry.place(x=12, y=630)

gen2_lf_freq_lbl = tk.Label(
    text="0 kHz"
)
gen2_lf_freq_lbl.place(x=10, y=650)

gen2_lf_phase_lbl = tk.Label(
    text="Phase"
)
gen2_lf_phase_lbl.place(x=10, y=670)

gen2_lf_phase_entry = tk.Entry(
    width=10
)
gen2_lf_phase_entry.place(x=12, y=690)

gen2_lf_amp_lbl = tk.Label(
    text="Amplitude"
)
gen2_lf_amp_lbl.place(x=10, y=710)

gen2_lf_amp_entry = tk.Entry(
    width=10
)
gen2_lf_amp_entry.place(x=12, y=730)

gen2_lf_amp_unit = tk.Label(
    text="V"
)
gen2_lf_amp_unit.place(x=77, y=730)

gen1_hf_lbl = tk.Label(
    text="High Frequency\nGenerator 1"
)
gen1_hf_lbl.place(x=130, y=360)

gen1_hf_period_lbl = tk.Label(
    text="Period"
)
gen1_hf_period_lbl.place(x=130, y=395)

gen1_hf_period_entry = tk.Entry(
    width=10,
)
gen1_hf_period_entry.place(x=132, y=415)

gen1_hf_freq_lbl = tk.Label(
    text="0 kHz"
)
gen1_hf_freq_lbl.place(x=130, y=435)

gen1_hf_phase_lbl = tk.Label(
    text="Phase"
)
gen1_hf_phase_lbl.place(x=130, y=455)

gen1_hf_phase_entry = tk.Entry(
    width=10
)
gen1_hf_phase_entry.place(x=132, y=475)

gen1_hf_amp_lbl = tk.Label(
    text="Amplitude"
)
gen1_hf_amp_lbl.place(x=130, y=495)

gen1_hf_amp_entry = tk.Entry(
    width=10
)
gen1_hf_amp_entry.place(x=132, y=515)

gen1_hf_amp_unit = tk.Label(
    text="V"
)
gen1_hf_amp_unit.place(x=197, y=515)

gen2_hf_lbl = tk.Label(
    text="High Frequency\nGenerator 2"
)
gen2_hf_lbl.place(x=130, y=575)

gen2_hf_period_lbl = tk.Label(
    text="Period"
)
gen2_hf_period_lbl.place(x=130, y=610)

gen2_hf_period_entry = tk.Entry(
    width=10,
)
gen2_hf_period_entry.place(x=132, y=630)

gen2_hf_freq_lbl = tk.Label(
    text="0 kHz"
)
gen2_hf_freq_lbl.place(x=130, y=650)

gen2_hf_phase_lbl = tk.Label(
    text="Phase"
)
gen2_hf_phase_lbl.place(x=130, y=670)

gen2_hf_phase_entry = tk.Entry(
    width=10
)
gen2_hf_phase_entry.place(x=132, y=690)

gen2_hf_amp_lbl = tk.Label(
    text="Amplitude"
)
gen2_hf_amp_lbl.place(x=130, y=710)

gen2_hf_amp_entry = tk.Entry(
    width=10
)
gen2_hf_amp_entry.place(x=132, y=730)

gen2_hf_amp_unit = tk.Label(
    text="V"
)
gen2_hf_amp_unit.place(x=197, y=730)

# Lock-in amplifier

lia_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=200
)
lia_frame.place(x=250, y=0)

lia_title = tk.Label(
    text="Lock-In Amplifier"
)
lia_title.place(x=320, y=10)

lia_in_lbl = tk.Label(
    text="Input Source: "
)
lia_in_lbl.place(x=260, y=45)

lia_in_var = tk.StringVar()
lia_in_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp"
]
lia_in_menu = tk.OptionMenu(
    window,
    lia_in_var,
    *lia_in_list
)
lia_in_menu.place(x=380, y=40)

lia_ref_lbl = tk.Label(
    text="Reference Source: "
)
lia_ref_lbl.place(x=260, y=75)

lia_ref_var = tk.StringVar()
lia_ref_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp"
]
lia_ref_menu = tk.OptionMenu(
    window,
    lia_ref_var,
    *lia_ref_list
)
lia_ref_menu.place(x=380, y=70)

lia_cut_lbl = tk.Label(
    text="Cutoff Frequency: "
)
lia_cut_lbl.place(x=260, y=105)

lia_cut_var = tk.StringVar()
lia_cut_list = [
    "640 kHz",
    "320 kHz",
    "160 kHz",
    "80 kHz",
    "40 kHz",
    "20 kHz",
    "10 kHz",
    "5.1 kHz",
    "2.6 KHz",
    "1.3 kHz",
    "640 Hz",
    "320 Hz",
    "160 Hz",
    "80 Hz",
    "40 Hz",
    "20 Hz"
]
lia_cut_menu = tk.OptionMenu(
    window,
    lia_cut_var,
    *lia_cut_list
)
lia_cut_menu.place(x=380, y=100)

lia_scale_lbl = tk.Label(
    text="Scale Factor: "
)
lia_scale_lbl.place(x=260, y=135)

lia_scale_entry = tk.Entry(
    width=10
)
lia_scale_entry.place(x=380, y=135)

lia_scale_unit = tk.Label(
    text="V/V"
)
lia_scale_unit.place(x=445, y=135)

# PID Controller

pid_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=300
)
pid_frame.place(x=250, y=200)

pid_title = tk.Label(
    text="PID Controller"
)
pid_title.place(x=320, y=210)

pid_in_lbl = tk.Label(
    text="Input Source: "
)
pid_in_lbl.place(x=260, y=245)

pid_in_var = tk.StringVar()
pid_in_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "Lock-In Out"
]
pid_in_menu = tk.OptionMenu(
    window,
    pid_in_var,
    *pid_in_list
)
pid_in_menu.place(x=380, y=240)

pid_set_lbl = tk.Label(
    text="Setpoint: "
)
pid_set_lbl.place(x=260, y=275)

pid_set_var = tk.StringVar()
pid_set_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "Lock-In Out",
    "Bus Setpoint"
]
pid_set_menu = tk.OptionMenu(
    window,
    pid_set_var,
    *pid_set_list
)
pid_set_menu.place(x=380, y=270)

pid_bus_set_lbl = tk.Label(
    text="Bus Setpoint: "
)
pid_bus_set_lbl.place(x=260, y=305)

pid_bus_set_entry = tk.Entry(
    width=10
)
pid_bus_set_entry.place(x=380, y=305)

pid_bus_set_unit = tk.Label(
    text="V"
)
pid_bus_set_unit.place(x=445, y=305)

pid_p_lbl = tk.Label(
    text="P Gain: "
)
pid_p_lbl.place(x=260, y=335)

pid_p_entry = tk.Entry(
    width=10
)
pid_p_entry.place(x=380, y=335)

pid_p_unit = tk.Label(
    text="V/V"
)
pid_p_unit.place(x=445, y=335)

pid_i_lbl = tk.Label(
    text="I Gain: "
)
pid_i_lbl.place(x=260, y=365)

pid_i_entry = tk.Entry(
    width=10
)
pid_i_entry.place(x=380, y=365)

pid_i_unit = tk.Label(
    text="1/s"
)
pid_i_unit.place(x=445, y=365)

pid_d_lbl = tk.Label(
    text="D Gain: "
)
pid_d_lbl.place(x=260, y=395)

pid_d_entry = tk.Entry(
    width=10
)
pid_d_entry.place(x=380, y=395)

pid_d_unit = tk.Label(
    text="ms"
)
pid_d_unit.place(x=445, y=395)

pid_max_lbl = tk.Label(
    text="Max Output: "
)
pid_max_lbl.place(x=260, y=425)

pid_max_entry = tk.Entry(
    width=10
)
pid_max_entry.place(x=380, y=425)

pid_max_unit = tk.Label(
    text="V"
)
pid_max_unit.place(x=445, y=425)

pid_min_lbl = tk.Label(
    text="Min Output: "
)
pid_min_lbl.place(x=260, y=455)

pid_min_entry = tk.Entry(
    width=10
)
pid_min_entry.place(x=380, y=455)

pid_min_unit = tk.Label(
    text="V"
)
pid_min_unit.place(x=445, y=455)

# Output Clamp Frame

clamp_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=300
)
clamp_frame.place(x=250, y=500)

clamp_title = tk.Label(
    text="Output Clamp"
)
clamp_title.place(x=325, y=510)

clamp1_lbl = tk.Label(
    text="Channel 1"
)
clamp1_lbl.place(x=260, y=540)

clamp1_check_var = tk.IntVar()
clamp1_check_var.set(0)
clamp1_enable_check = tk.Checkbutton(
    text="Enable",
    variable=clamp1_check_var,
    onvalue=1,
    offvalue=0
)
clamp1_enable_check.place(x=260, y=560)

clamp1_max_lbl = tk.Label(
    text="Maximum: "
)
clamp1_max_lbl.place(x=260, y=590)

clamp1_max_entry = tk.Entry(
    width=10
)
clamp1_max_entry.place(x=380, y=590)

clamp1_max_unit = tk.Label(
    text="V"
)
clamp1_max_unit.place(x=445, y=590)

clamp1_min_lbl = tk.Label(
    text="Minimum: "
)
clamp1_min_lbl.place(x=260, y=620)

clamp1_min_entry = tk.Entry(
    width=10
)
clamp1_min_entry.place(x=380, y=620)

clamp1_min_unit = tk.Label(
    text="V"
)
clamp1_min_unit.place(x=445, y=620)

clamp2_lbl = tk.Label(
    text="Channel 2"
)
clamp2_lbl.place(x=260, y=660)

clamp2_check_var = tk.IntVar()
clamp2_check_var.set(0)
clamp2_enable_check = tk.Checkbutton(
    text="Enable",
    variable=clamp2_check_var,
    onvalue=1,
    offvalue=0
)
clamp2_enable_check.place(x=260, y=680)

clamp2_max_lbl = tk.Label(
    text="Maximum: "
)
clamp2_max_lbl.place(x=260, y=710)

clamp2_max_entry = tk.Entry(
    width=10
)
clamp2_max_entry.place(x=380, y=710)

clamp2_max_unit = tk.Label(
    text="V"
)
clamp2_max_unit.place(x=445, y=710)

clamp2_min_lbl = tk.Label(
    text="Minimum: "
)
clamp2_min_lbl.place(x=260, y=740)

clamp2_min_entry = tk.Entry(
    width=10
)
clamp2_min_entry.place(x=380, y=740)

clamp2_min_unit = tk.Label(
    text="V"
)
clamp2_min_unit.place(x=445, y=740)

# Output Frame

out_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=170
)
out_frame.place(x=500, y=0)

out_title = tk.Label(
    text="Outputs"
)
out_title.place(x=600, y=10)

out1_lbl = tk.Label(
    text="Output 1"
)
out1_lbl.place(x=510, y=45)

out1_var = tk.StringVar()
out1_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error",
    "Bus Output 1",
    "Operations 1",
    "Operations 2"
]
out1_menu = tk.OptionMenu(
    window,
    out1_var,
    *out1_list
)
out1_menu.place(x=630, y=40)

out1_bus_lbl = tk.Label(
    text="Bus Output 1: "
)
out1_bus_lbl.place(x=510, y=75)

out1_bus_entry = tk.Entry(
    width=10
)
out1_bus_entry.place(x=630, y=75)

out1_bus_unit = tk.Label(
    text="V"
)
out1_bus_unit.place(x=695, y=75)

out2_lbl = tk.Label(
    text="Output 2"
)
out2_lbl.place(x=510, y=105)

out2_var = tk.StringVar()
out2_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error",
    "Bus Output 2",
    "Operations 1",
    "Operations 2"
]
out2_menu = tk.OptionMenu(
    window,
    out2_var,
    *out2_list
)
out2_menu.place(x=630, y=100)

out2_bus_lbl = tk.Label(
    text="Bus Output 2: "
)
out2_bus_lbl.place(x=510, y=135)

out2_bus_entry = tk.Entry(
    width=10
)
out2_bus_entry.place(x=630, y=135)

out2_bus_unit = tk.Label(
    text="V"
)
out2_bus_unit.place(x=695, y=135)

# Ramp Frame

ramp_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=200
)
ramp_frame.place(x=500, y=170)

ramp_title = tk.Label(
    text="Ramp Generator"
)

ramp_title.place(x=580, y=180)

ramp_period_lbl = tk.Label(
    text="Period"
)
ramp_period_lbl.place(x=510, y=220)

ramp_period_entry = tk.Entry(
    width=10,
)
ramp_period_entry.place(x=512, y=240)

ramp_freq_lbl = tk.Label(
    text="0 kHz"
)
ramp_freq_lbl.place(x=510, y=260)

ramp_amp_lbl = tk.Label(
    text="Amplitude"
)
ramp_amp_lbl.place(x=510, y=300)

ramp_amp_entry = tk.Entry(
    width=10
)
ramp_amp_entry.place(x=512, y=320)

ramp_amp_unit = tk.Label(
    text="V"
)
ramp_amp_unit.place(x=577, y=320)

# Operations Frame

op_frame = tk.Frame(
    relief=tk.GROOVE,
    borderwidth=2,
    width=250,
    height=320
)
op_frame.place(x=500, y=370)

op_title = tk.Label(
    text="Output Operations"
)
op_title.place(x=560, y=380)

op1_lbl = tk.Label(
    text="Operations 1"
)
op1_lbl.place(x=510, y=415)

op1_in_1_lbl = tk.Label(
    text="Input A"
)

op1_in_1_lbl.place(x=510, y=450)

op1_in_1_var = tk.StringVar()
op1_in_1_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error"
]
op1_in_1_menu = tk.OptionMenu(
    window,
    op1_in_1_var,
    *op1_in_1_list
)
op1_in_1_menu.place(x=630, y=445)

op1_in_2_lbl = tk.Label(
    text="Input B"
)

op1_in_2_lbl.place(x=510, y=480)

op1_in_2_var = tk.StringVar()
op1_in_2_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error"
]

op1_in_2_menu = tk.OptionMenu(
    window,
    op1_in_2_var,
    *op1_in_2_list
)
op1_in_2_menu.place(x=630, y=475)

op1_out_lbl = tk.Label(
    text="Operation"
)

op1_out_lbl.place(x=510, y=510)

op1_out_var = tk.StringVar()
op1_out_list = [
    "Zero",
    "A + B",
    "A - B",
    "B - A",
    "-A",
    "-B"
]
op1_out_menu = tk.OptionMenu(
    window,
    op1_out_var,
    *op1_out_list
)
op1_out_menu.place(x=630, y=505)

op2_lbl = tk.Label(
    text="Operations 2"
)
op2_lbl.place(x=510, y=545)

op2_in_1_lbl = tk.Label(
    text="Input A"
)

op2_in_1_lbl.place(x=510, y=580)

op2_in_1_var = tk.StringVar()
op2_in_1_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error"
]
op2_in_1_menu = tk.OptionMenu(
    window,
    op2_in_1_var,
    *op2_in_1_list
)
op2_in_1_menu.place(x=630, y=575)

op2_in_2_lbl = tk.Label(
    text="Input B"
)

op2_in_2_lbl.place(x=510, y=610)

op2_in_2_var = tk.StringVar()
op2_in_2_list = [
    "Zero",
    "Ch1",
    "Ch2",
    "Ch1 + Ch2",
    "Ch1 - Ch2",
    "Ch2 - Ch1",
    "-Ch1",
    "-Ch2",
    "LF Sine 1",
    "LF Sine 2",
    "HF Sine 1",
    "HF Sine 2",
    "Ramp",
    "Lock-In Out",
    "PID Out",
    "PID Error"
]

op2_in_2_menu = tk.OptionMenu(
    window,
    op2_in_2_var,
    *op2_in_2_list
)
op2_in_2_menu.place(x=630, y=605)

op2_out_lbl = tk.Label(
    text="Operation"
)

op2_out_lbl.place(x=510, y=640)

op2_out_var = tk.StringVar()
op2_out_list = [
    "Zero",
    "A + B",
    "A - B",
    "B - A",
    "-A",
    "-B"
]
op2_out_menu = tk.OptionMenu(
    window,
    op2_out_var,
    *op2_out_list
)
op2_out_menu.place(x=630, y=635)

# Buttons

off_button = tk.Button(text="Off", bg="red", width=15, height=3, command=off_command)
off_button.place(x=1055, y=220)

save_button = tk.Button(text="Save", width=15, height=3, command=save_command)
save_button.place(x=1055, y=130)

update_button = tk.Button(text="Update", width=15, height=3, command=update_command)
update_button.place(x=1055, y=40)

# Startup

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect("rp-f07794.local", username="root", password="root")
print("Connected to Red Pitaya")

ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("ls /lock")
file_lines = ssh_stdout.readlines()
mem_exists = False
bit_exists = False
for filename in file_lines:
    if filename == "mem.txt\n":
        mem_exists = True
        print("Memory File Found")
    elif filename == "red_pitaya_top.bit\n":
        bit_exists = True
        print("Bitstream Found")

if not bit_exists:
    sys.exit("Bitstream not found. Exiting.")
else:
    ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("cat /lock/red_pitaya_top.bit > /dev/xdevcfg")
    print("Bitstream Loaded")

param_list = []
if mem_exists:
    ssh_stdin, ssh_stdout, ssh_stderr = ssh.exec_command("cat /lock/mem.txt")
    param_lines = ssh_stdout.readlines()
    for param in param_lines:
        param_list.append(param[:-1])  # Remove newline character
    if len(param_list) != 51:
        print("Memory File Invalid. Switching to Default.")
        mem_exists = False

default_list = [
    "1",
    "0",
    "1",
    "0",
    "1",
    "0",
    "1",
    "0",
    "1",
    "0",
    "0",
    "1",
    "0",
    "0",
    "1",
    "0",
    "0",
    "1",
    "0",
    "0",
    "1",
    "Zero",
    "Zero",
    "640 kHz",
    "1",
    "Zero",
    "Zero",
    "0",
    "0",
    "0",
    "0",
    "1",
    "-1",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "Zero",
    "0",
    "Zero",
    "0",
    "0",
    "1",
    "Zero",
    "Zero",
    "Zero",
    "Zero",
    "Zero",
    "Zero",
]

if not mem_exists:
    param_list = default_list

calibration_check_var.set(int(param_list[0]))
ch1_in_offset_entry.insert(0, param_list[1])
ch1_in_gain_entry.insert(0, param_list[2])
ch2_in_offset_entry.insert(0, param_list[3])
ch2_in_gain_entry.insert(0, param_list[4])
ch1_out_offset_entry.insert(0, param_list[5])
ch1_out_gain_entry.insert(0, param_list[6])
ch2_out_offset_entry.insert(0, param_list[7])
ch2_out_gain_entry.insert(0, param_list[8])
gen1_lf_period_entry.insert(0, param_list[9])
gen1_lf_phase_entry.insert(0, param_list[10])
gen1_lf_amp_entry.insert(0, param_list[11])
gen2_lf_period_entry.insert(0, param_list[12])
gen2_lf_phase_entry.insert(0, param_list[13])
gen2_lf_amp_entry.insert(0, param_list[14])
gen1_hf_period_entry.insert(0, param_list[15])
gen1_hf_phase_entry.insert(0, param_list[16])
gen1_hf_amp_entry.insert(0, param_list[17])
gen2_hf_period_entry.insert(0, param_list[18])
gen2_hf_phase_entry.insert(0, param_list[19])
gen2_hf_amp_entry.insert(0, param_list[20])
lia_in_var.set(param_list[21])
lia_ref_var.set(param_list[22])
lia_cut_var.set(param_list[23])
lia_scale_entry.insert(0, param_list[24])
pid_in_var.set(param_list[25])
pid_set_var.set(param_list[26])
pid_bus_set_entry.insert(0, param_list[27])
pid_p_entry.insert(0, param_list[28])
pid_i_entry.insert(0, param_list[29])
pid_d_entry.insert(0, param_list[30])
pid_max_entry.insert(0, param_list[31])
pid_min_entry.insert(0, param_list[32])
clamp1_check_var.set(param_list[33])
clamp1_max_entry.insert(0, param_list[34])
clamp1_min_entry.insert(0, param_list[35])
clamp2_check_var.set(param_list[36])
clamp2_max_entry.insert(0, param_list[37])
clamp2_min_entry.insert(0, param_list[38])
out1_var.set(param_list[39])
out1_bus_entry.insert(0, param_list[40])
out2_var.set(param_list[41])
out2_bus_entry.insert(0, param_list[42])
ramp_period_entry.insert(0, param_list[43])
ramp_amp_entry.insert(0, param_list[44])
op1_in_1_var.set(param_list[45])
op1_in_2_var.set(param_list[46])
op1_out_var.set(param_list[47])
op2_in_1_var.set(param_list[48])
op2_in_2_var.set(param_list[49])
op2_out_var.set(param_list[50])

window.mainloop()
