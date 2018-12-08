;因为(magnitude z)中的z的标志是complex，并没有为这个附加magnitude方法
;所以添加下面的3个东西
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)