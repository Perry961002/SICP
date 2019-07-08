; 因为原来的lives-near规则定义中，它的两个参数对位置无敏感, 符合交换律
; 因此需要使用一个不满足交换律的操作去替换原来的same

(define greater-as-string (obj1 obj2)
  (string>?
    (write-to-string obj1)
    (write-to-string obj2)))

(rule (lives-near ?p1 ?p2)
  (and (address ?p1 (?town . ?rest-1))
       (address ?p2 (?town . ?rest-2))
       (lisp-value #'greater-as-string ?p1 ?p2)))