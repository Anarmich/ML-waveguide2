# Description

This work is a study of acoustic non-reciprocity exhibited by a passive (i.e., with no active or semi-active feedback) one-dimensional (1D) linear waveguide incorporating two local strongly nonlinear, asymmetric gates. Strong coupling between the constituent oscillators of the linear waveguide is assumed, resulting in broadband capacity for wave transmission in its passband. Two local nonlinear gates break the symmetry and linearity of the waveguide, yielding strong global non-reciprocal acoustics, in the way that extremely different acoustical responses occur depending on the side of application of harmonic excitation, that is, for left-to-right (L-R) or right-to-left (R-L) wave propagation. To the authors’ best knowledge that the present two-gated waveguide is capable of extremely high acoustic non-reciprocity, at a much higher level to what is reported by active or passive devices in the current literature; moreover, this extreme performance combines with acceptable levels of transmissibility in the desired (preferred) direction of wave propagation. Machine learning is utilized for predictive design of this gated waveguide in terms of the measures of transmissibility and non-reciprocity, with the aim of reducing the required computational time for high-dimensional parameter space analysis. The study sheds new light into the physics of these media and considers the advantages and limitations of using neural networks (NNs) to analyze this type of physical problems. In the predicted desirable parameter space for intense non-reciprocity, the maximum transmissibility reaches as much as 40%, and the transmitted energy from upstream (i.e., the part of the waveguide where the excitation is applied) to downstream (i.e., in the part of the waveguide after the two nonlinear gates) varies by up to nine orders of magnitude, depending on the direction of wave transmission. The machine learning tools along with the numerical methods of this work can inform predictive designs of practical non-reciprocal waveguides and acoustic metamaterials that incorporate local nonlinear gates. The current paper shows that combinations of nonlinear gates can lead to extremely high non-reciprocity while maintaining desired levels of transmissibility. This could lead to future investigation of how multiple nonlinear gates can be used as building blocks of designs incorporating robust passive acoustic non-reciprocity.

You can find our paper here: https://arxiv.org/abs/2302.01746 alongside its journal extended version: https://link.springer.com/article/10.1007/s11071-023-08765-4.

## Citation
If you use this project in your research or wish to refer to the baseline results published in the paper, please use the following BibTeX entry.

```bibtex
@article{michaloliakos2023machine,
  title={Machine learning extreme acoustic non-reciprocity in a linear waveguide with multiple nonlinear asymmetric gates},
  author={Michaloliakos, Anargyros and Wang, Chunyang and Vakakis, Alexander F.},
  journal={Nonlinear Dynamics},
  year={2023},
  volume={111},
  pages={17277--17297},
  publisher={Springer},
  doi={10.1007/s11071-023-08765-4}
}
```
## Model Setup

The governing equations of motion are established considering the oscillators in the linear sub-waveguides, with `ω₀ = √(k/m)` representing the natural frequencies. The non-dimensional time is denoted as `τ = ω₀t`. Introducing the normalizations:

- `d = k_L/k` (normalized intercoupling stiffness),
- `ξ = c/2√mk` (critical viscous damping ratio),
- `ω̂ = ω/ω₀` (normalized excitation frequency),
- `A_p = F_p/(dk)` (normalized excitation magnitude),
- `α₁ = k_c1/k_L` and `α₂ = k_c2/k_L` (normalized nonlinear coefficients),
- `σ = (k₁ - k) / k_L` (normalized stiffness detuning parameter),

the equations of motion are expressed in normalized form with all initial conditions assumed to be zero. These equations account for the dynamics of each oscillator in the system, addressing interactions through normalized stiffness and damping terms.

### Forcing Configuration and System Parameters

The upstream and downstream linear sub-waveguides are indicated by oscillator displacements `x_p` and `y_p` (`p=0,…,N`), with central region oscillators denoted as `z_0`, `z_1`, and `z_00`. Nonlinear gates link `x_0` with `z_0` and `z_00` with `y_0`, forming crucial components of our system's non-reciprocal transmission properties.

The normalized dispersion relation without the gates is given by:

Ω/ω₀ = √(1 + 4d sin² (θ/2)), 0 ≤ θ ≤ π


This equation defines the frequency and wavenumber ranges allowing harmonic waves to propagate uninhibited through the acoustic medium, identified by the normalized passband of each sub-waveguide.

### Numerical Simulations

Numerical integration of the normalized equations of motion (1) is conducted for three different configurations, over a total simulation time of `0 ≤ τ ≤ 1500`. This process aims to delineate the types of nonlinear acoustics manifesting in the waveguide under various system and excitation parameters.

#### System Configurations

Three distinct system configurations are examined:

- **System 1**: Characterized by parameters `d = 0.5`, `{α₁, α₂} = {0.15, 0.3}`, `ξ = 0.013`, `θ = 1/6π`, `σ = -1.5`, `A_p = 1.0`, `p = 4`.
- **System 2**: Defined by `d = 0.34697`, `{α₁, α₂} = {1.8133, 3.4525}`, `ξ = 0.023`, `θ = 2.502/6π`, `σ = -1.4`, `A_p = 0.45989`, `p = 4`.
- **System 3**: Set with `d = 0.4`, `{α₁, α₂} = {3.9, 3.1}`, `ξ = 0.013`, `θ = 3/6π`, `σ = -1.4`, `A_p = 0.4`, `p = 4`.

These systems are specifically configured to test the waveguide's response under varying non-linearities and excitation parameters, providing a comprehensive understanding of the acoustic transmission properties in engineered waveguide systems.

## Equations of Motion

The normalized equations of motion are formulated as follows, incorporating complex conjugates and non-linear interactions among oscillators:

```plaintext
x_i'' + 2ξx_i + x_i + d(x_i - x_(i-1)) + d(x_i - x_(i+1)) = [dA_pe^(jω̂τ) + cc]δ(i-p), for i = 1,2,...,N-1
x_0'' + 2ξx_0' + α(1 + dσ)x_0 + dα_1(x_0 - z_0)^3 + d(x_0 - x_1) = 0
z_0'' + 2ξz_0' + (1 + dσ)z_0 + dα_1(z_0 - x_0)^3 + d(z_0 - z_1) = 0
z_1'' + 2ξz_1' + z_1 + d(z_1 - z_0) + d(z_1 - z_00) = 0
z_00'' + 2ξz_00' + (1 + dσ)z_00 + dα_2(z_00 - y_0)^3 + d(z_00 - z_1) = 0
y_0'' + 2ξy_0' + (1 + dσ)y_0 + dα_2(y_0 - z_00)^3 + d(y_0 - y_1) = 0
y_n'' + y_n + 2ξy_n' + d(y_n - y_(n-1)) + d(y_n - y_(n+1)) = 0, for n = 1,2,...,N-1
```
## Energy Analysis

The study of the harmonic content of transmitted waves is conducted by observing the amplitude of the discrete Fourier transform of the response `y₀`, the oscillator after the second gate. The analysis is performed for both Left-to-Right (L-R) and Right-to-Left (R-L) wave transmission. Notably, only a single dominant harmonic is observed at the frequency of the exerted harmonic excitation, indicating that the transmitted waves are nearly monochromatic at a steady state in both transmission directions.

### Energy Measures

The energy measures provide insight into the non-reciprocal features of the nonlinear acoustics. These measures are derived by evaluating the total work exerted by the applied external force and the energy transmitted to the downstream sub-waveguide, thereby facilitating the study of non-reciprocity and transmissibility in the waveguide from an energy perspective.

Following the methodologies outlined in [17], the formulas for the exerted work (input energy by the force) up to time `τ`, `E_input(τ)`, and the energy transmitted through the gate to the downstream waveguide up to time `τ`, `E_downL-R(τ)` for L-R propagation and `E_downR-L(τ)` for R-L propagation, are given by:

```plaintext
E_input(τ) = \int_0^τ 2dA_p \cos(ω̂τ₀) x'_p dτ₀ \quad (L - R)\\
E_input(τ) = \int_0^τ 2dA_p \cos(ω̂τ₀) y'_p dτ₀ \quad (R - L)\\

E_downL-R(τ) = \int_0^τ d(y₀ - y₁)y'_₀ dτ₀\\
E_downR-L(τ) = \int_0^τ d(x₀ - x₁)x'_₀ dτ₀
```

## Diagram of Branched Waveguide

Focusing on the region with transmissibility measure, \( \eta > 0.2 \), we define the three branches of solutions, namely, (i) a highly non-reciprocal branch (HNRB) corresponding to \( 5 < \delta < 9 \), (ii) an intermediate non-reciprocal branch (INRB) for \( 1 < \delta < 5 \), and (iii) a near-reciprocal branch (NRB) for \( \delta \ll 1 \)

Diagram illustrating the branches of solutions: waveguide model used in our studies:

![Branched Waveguide](/images/Branched.png)

## Machine learning approach for predictable design

A machine learning model is developed to offer a cost-effective alternative to direct numerical simulations of a strongly coupled gated waveguide. This model, which inputs five variables (A_p, α1, α2, ω, d), outputs measures of non-reciprocity (δ) and transmissibility (η). Built on prior models, it significantly reduces simulation time while maintaining accuracy and reliability in predicting nonlinear acoustics. 

The model is trained using an artificial neural network (NN) consisting of 4 hidden layers with 50 neurons each, employing ReLU activation functions for hidden layers and a linear function for the output layer. Inputs and outputs are normalized and converted into vectors of dimensions (5 x 1) and (2 x 1) respectively, where input values are scaled between -1 and +1. The neural network iteratively computes outputs starting from the input layer, using learned weights and biases, with each layer's output feeding into the next.

![NN robust sol](/images/Neural-Network.png)

To demonstrate the robustness of the NN simulator and its efficiency, we highlight results in Fig. 12, where we show the NN's performance classification on the test set. We examine the case where (d, A_p, θ) = (0.2, 0.4, 3.2659/6π) with varying nonlinear coefficients (α1, α2). A selected region, marked in light green for α1 = 5.0 and α2 = 3.1, illustrates the predicted region of desired performance. This region is further visualized by a square representing the "kernel size", which quantifies performance robustness under parameter variations. Specifically, with intra-waveguide coupling stiffness fixed at d = 0.2, a contour plot maps out kernel size variations as a function of A_p and θ. For A_p = 0.4 and θ = 3.2659/6π, the optimal robustness point is indicated, supporting the NN's ability to produce reliable and computationally efficient solutions.

![NN robust sol](/images/robust.png)

![NN robust sol](/images/out1.png)
## Copyright and license
University of Illinois Open Source License

Copyright © 2023, University of Illinois at Urbana Champaign. All rights reserved.

Developed by: Michaloliakos, Anargyros and Wang, Chunyang and Vakakis, Alexander F.

1: University of Illinois at Urbana-Champaign

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal with the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimers. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimers in the documentation and/or other materials provided with the distribution. Neither the names of Computational Audio Group, University of Illinois at Urbana-Champaign, nor the names of its contributors may be used to endorse or promote products derived from this Software without specific prior written permission. THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.
