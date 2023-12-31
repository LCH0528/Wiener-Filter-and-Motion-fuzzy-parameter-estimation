# Wiener-Filter-and-Motion-fuzzy-parameter-estimation
本项目里主要有三个部分：匀速直线运动情况下图像的运动模糊过程仿真、维纳滤波及影响其复原效果的因素、运动模糊参数估计。


文件夹及其代码文件说明：

1. 模糊化：

(1) 匀速直线运动情况下图像的运动模糊过程仿真。
其中，代码文件见“维纳滤波”文件夹中的winner0.m文件（前半部分代码），或者参考“模糊化”文件夹中的两个代码文件。

(2) 探究模糊长度和角度对运动模糊效果的影响。
代码文件：
len.m：不同模糊长度下的运动模糊图像。
theta.m：不同模糊角度下的运动模糊图像。


2. 维纳滤波：

(1) 对比逆滤波和维纳滤波的复原效果。
代码文件：
winner0.m：探究分别在有无高斯白噪声情况下，逆滤波和维纳滤波的复原效果。对于维纳滤波，分别以实际的噪信比NSR和K值作为噪信比。

(2) 探究影响维纳滤波复原效果的因素：分别对不同模糊长度、高斯白噪声方差、噪信比（K值）这三个因素下维纳滤波的复原效果进行了仿真。
代码文件：
winner_filter.m：函数文件，其输入为运动模糊图像、噪声方差、模糊长度、模糊角度，输出为逆滤波、维纳滤波（以NSR和K值作为噪信比）下的复原图像。
winner_LEN.m：探究模糊长度对逆滤波和维纳滤波的复原效果的影响。
winner_noise.m：探究噪声方差对逆滤波和维纳滤波的复原效果的影响。
winner_K_NSR.m：探究K值对维纳滤波效果的影响。

(3) 有参考图像的客观评价指标。
calculate_MSE.m：均方误差 MSE。
calculate_SNR.m：信噪比SNR、峰值信噪比 PSNR、信噪比改善因子 ISNR。

(4) K_NSR_figure.m：客观评价指标-K值曲线。
分别计算不同K值下有参考图像的客观评价指标：MSE（均方误差）、SNR（信噪比）、PSNR（峰值信噪比）、ISNR（信噪比改善因子），并分别绘制MSE-K、SNR-K、PSNR-K、ISNR-K四条曲线。


3. 运动模糊参数估计：

(1) theta_search.m：模糊角度估计。
模糊角度主要通过两次傅里叶变换和归一化Radon变换相结合的方法进行估计，其主要流程如下：
(a) 对于理想的运动模糊图像，首先需要对模糊图像作两次傅里叶变换并中心化，得到模糊图像的二次频谱图。然后，用Canny算子对二次频谱图进行边缘检测，得到二值化图像。最后，对二值化图像进行归一化Radon变换，并通过变换结果计算出模糊角度的估计值。
(b) 相较于理想的运动模糊图像，实际的运动模糊图像的模糊角度的估计方法有一些改进：首先需要去除二次频谱图中的十字亮线，然后进行灰度变换，最后进行二值化和归一化Radon变换，得到模糊角度的估计值。
说明：理想的运动模糊图像：参考前面所述代码，通过MATLAB使原始图像退化，得到理想的运动模糊图像，其只含高斯白噪声。然而，实际的运动模糊图像中的噪声一般不是高斯白噪声。

(2) len_search.m：模糊长度估计。
模糊长度主要通过倒频谱法进行估计。

(3) C_g_show.m：运动模糊图像的倒频谱的特性。
代码中，选取大小为101*101的灰度图像（中间是大小为3*3的、灰度值为255的白色部分，其他部分的灰度均为0），通过三维表示对应的倒频谱图像，说明运动模糊图像的倒频谱的特性。

(4) error_analysis.m：作出模糊长度和模糊角度的误差曲线，观察曲线进行误差分析。
说明：执行模糊参数估计函数前需要把函数内关于作图的语句给注释掉

(5) K值估计
对于理想的运动模糊图像，通过对比MSE-K、SNR-K、PSNR-K、ISNR-K四条曲线，最终选择MSE作为K值估计的指标。其中，MSE越小，表明复原效果越好，对应的K值可作为估计的K值，即最佳K值。
对于实际的运动模糊图像，采用无参考图像的客观评价指标对复原效果进行评价：H（熵）、GMG（平均灰度梯度）、SF（空间频率）。
代码文件：
K_blurred_search.m：比较网格法（粗搜索）和粒子群算法搜索 K 值，并作出粒子群算法的适应度曲线。
K_search.m：用粒子群算法估计 K 值（含有无参考图像的评价指标）。
MSE_search.m：适应度（MSE）。
说明：代码中，分别用网格法和粒子群算法搜索MSE的最小值及其对应的最佳K值。其中，MSE或者H同时也是粒子群算法的适应度。

(6) 无参考图像的客观评价指标。
calculate_GMG.m：平均灰度梯度GMG。
calculate_SF.m：空间频率SF。
说明：在MATLAB中有计算图像的熵H的内置函数entropy。

(7) wiener_filter_best.m：函数文件，用于估计模糊参数：模糊角度、模糊长度、K值。

(8) WIENER_Processing.m：理想的运动模糊图像的参数估计和维纳滤波。

(9) 实际的运动模糊图像的参数估计和维纳滤波。
WIENER_Processing_realimage.m：实际的运动模糊图像的参数估计和维纳滤波。
WIENER_Processing_realimage2.m：与前面所述的参数估计方法不同，先用前面的方法估计模糊角度，再通过主观比较不同模糊长度和K值下的复原图像，并将复原效果最好的图像对应的模糊长度和K值作为其估计值，最后进行维纳滤波。




译文（Translation）：
There are three main sections in this project: simulation of the motion blur process for images in the case of uniform linear motion, Wiener filtering and the factors affecting its recovery, and estimation of motion blur parameters.


Folders and their code files are described as follows:

1. Blurring:

(1) Simulation of motion blurring of an image in the case of uniform linear motion.
The code files can be found in the Winner0.m file (first half of the code) in the Wiener Filter folder, or in the two code files in the Blurring folder.

(2) Investigate the effect of blur length and angle on motion blur effects.
Code files:
len.m: motion blur image with different blur lengths.
theta.m: motion blur image with different blur angles. 2.


2. Wiener filtering:

(1) Compare the recovery effect of inverse filtering and Wiener filtering.
Code file:
winner0.m: Explore the recovery effect of inverse filtering and Wiener filtering with and without Gaussian white noise, respectively. For Wiener filtering, the actual noise to signal ratio NSR and K values are used as the noise to signal ratio respectively.

(2) Investigate the factors affecting the recovery effect of Wiener filtering: The recovery effect of Wiener filtering with different blur lengths, Gaussian white noise variance and noise to signal ratio (K value) were simulated.
Code files:
winner_filter.m: function file whose input is the motion blur image, noise variance, blur length, blur angle, and output is the recovered image under inverse filtering and Wiener filtering (with NSR and K values as noise to signal ratio).
winner_LEN.m: Investigates the effect of blur length on the recovery of inverse and wiener filters.
winner_noise.m: Investigates the effect of noise variance on the recovery of inverse and Wiener filters.
winner_K_NSR.m: Investigating the effect of K on the effect of Wiener filtering.

(3) Objective evaluation metrics with reference images.
calculate_MSE.m: Mean Square Error MSE.
calculate_SNR.m: signal-to-noise ratio SNR, peak signal-to-noise ratio PSNR, signal-to-noise ratio improvement factor ISNR.

(4) K_NSR_figure.m: objective evaluation index-K curve.
Calculate the objective evaluation metrics with reference images at different K values: MSE (mean square error), SNR (signal-to-noise ratio), PSNR (peak signal-to-noise ratio), ISNR (signal-to-noise ratio improvement factor), respectively, and plot the four curves of MSE-K, SNR-K, PSNR-K, ISNR-K, respectively.


3. Motion blur parameter estimation:

(1) theta_search.m: fuzzy angle estimation.
The fuzzy angle is mainly estimated by a combination of two Fourier transforms and the normalised Radon transform, the main process of which is as follows:
(a) For an ideal motion blur image, the blurred image first needs to be Fourier transformed twice and centred to obtain a quadratic spectrogram of the blurred image. Then, the Canny operator is used to perform edge detection on the quadratic spectrogram to obtain the binarized image. Finally, the binarised image is subjected to the normalised Radon transform and an estimate of the blur angle is calculated from the transform result.
(b) Compared to the ideal motion blur image, there are some improvements in the estimation method of the blur angle of the actual motion blur image: firstly, the cross bright lines in the quadratic spectrogram need to be removed, then the grey scale transformation is performed, and finally the binarisation and normalised Radon transformation are performed to obtain the estimate of the blur angle.
Illustration: Ideal motion blur image: Referring to the code described earlier, the original image is degraded by MATLAB to obtain an ideal motion blur image, which contains only Gaussian white noise. However, the noise in the actual motion blur image is generally not Gaussian white noise.
