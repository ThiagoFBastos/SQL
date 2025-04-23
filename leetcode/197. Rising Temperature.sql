SELECT W2.ID
FROM Weather W1 INNER JOIN Weather W2 ON W1.recordDate + 1 = W2.recordDate AND W1.temperature < W2.temperature;