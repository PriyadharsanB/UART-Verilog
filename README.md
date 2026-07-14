# UART-Verilog

UART Transmitter and Receiver in Verilog

A Universal Asynchronous Receiver Transmitter (UART) implemented in Verilog HDL using Finite State Machines (FSMs). The project includes independent UART transmitter (TX) and receiver (RX) modules, along with simulation testbenches and an end-to-end loopback verification in Xilinx Vivado.

---

## Features

- UART Transmitter (TX)
- UART Receiver (RX)
- FSM-based architecture
- Baud rate generation
- Parallel-to-Serial conversion
- Serial-to-Parallel conversion
- Independent TX and RX verification
- End-to-End Loopback Verification

---

## Project Structure

```
UART-Verilog/
│
├── src/
│   ├── UART1_TX.v
│   ├── UART1_RX.v
│   └── UART1_TOP.v
│
├── testbench/
│   ├── UART1_TX_TB.v
│   ├── UART1_RX_TB.v
│   └── UART1_TOP_TB.v
│
├── waveforms/
│   └── loopback_test.png
│
└── README.md
```

---

## UART Frame Format

The implementation uses the standard 8-bit UART frame:

```
| Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop |
|   0   |          8 Data Bits (LSB First)          |  1   |
```

- Start Bit : 1
- Data Bits : 8
- Stop Bit  : 1
- Transmission Order : Least Significant Bit (LSB) First

---

## Verification

The design was verified using Vivado simulations.

### UART Transmitter
- Verified idle condition
- Verified start bit generation
- Verified serial transmission of 8-bit data
- Verified stop bit generation

### UART Receiver
- Verified start bit detection
- Verified mid-bit sampling
- Verified serial-to-parallel reconstruction
- Verified received output matches transmitted data

### Loopback Test

The transmitter output was directly connected to the receiver input.

Multiple data bytes were transmitted successfully:

| Transmitted | Received |
|-------------|----------|
| 0x54 | 0x54 |
| 0xA5 | 0xA5 |
| 0x3C | 0x3C |

This confirms correct end-to-end UART communication.

---

## Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

---

## Future Improvements

- Common Baud Generator Module
- Parity Bit Generation
- Parity Error Detection
- Configurable Baud Rate
- Configurable Data Width

---

## Author

**Priyadharsan B**

- GitHub: https://github.com/PriyadharsanB
- LinkedIn: https://www.linkedin.com/in/bpriyadharsan
