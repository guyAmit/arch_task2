from subprocess import Popen, PIPE
from random import uniform
from random import randint


COEFFRANGE=100
ORDER=150

def GanerateTest(i):
    f = open("tests/test"+str(i)+".txt", "w+")
    f.write("epsilon = 1.0e-10\n")
    order = randint(1, ORDER)
    f.write("order = "+str(order)+"\n")
    for n in range(0,order+1):
        f.write("coeff "+str(n)+" = "+str(uniform(-1*COEFFRANGE, COEFFRANGE))+" "+str(uniform(-1*COEFFRANGE, COEFFRANGE))+"\n")
    f.write("initial = "+str(uniform(-10, 10))+" "+str(uniform(-10, 10))+"\n")
    f.close()




def eval_pol(test,real,img):
    real = float(real)
    img = float(img)
    realpower = 1             #temp power real
    imgpower = 0              #temp power img
    f = open(test, "r")
    next(f)
    order = f.readline()
    order = int((order.split(" "))[2])

    coeff = f.readline()
    coeff = coeff.split(" ")
    resultReal = float(coeff[3])
    resultImg = float(coeff[4])
    for i in range(0, order):
        #power = power * resultFromTest
        tempReal = realpower
        realpower = (tempReal * real - imgpower * img)
        imgpower = (tempReal * img + imgpower*real)

        coeff = f.readline()
        coeff = coeff.split(" ")
        coeffReal = float(coeff[3])
        coeffImg = float(coeff[4])
        tempReal = coeffReal
        coeffReal = (tempReal * realpower - coeffImg * imgpower)
        coeffImg = (tempReal * imgpower + coeffImg * realpower)

        resultReal = resultReal + coeffReal
        resultImg = resultImg + coeffImg

    f.close()
    result = pow(pow(resultImg,2)+pow(resultReal,2),0.5)
    return result





def TestResults(i,real,img):
    f = open("tests/test"+str(i)+".txt", "a")
    f.write("your result {0} {1} ".format(real,img))
    f.close()
    result = eval_pol("tests/test"+str(i)+".txt",ans[2],ans[3])
    if result <= 1.0e-10:
        return True
    return False

for i in range(0, 10):
   GanerateTest(i)


for i in range(0, 10):
    process = Popen(["./root < tests/test"+str(i)+".txt"], stdout=PIPE, shell=True)
    (output, err) = process.communicate()
    exit_code = process.wait()
    ans = output.decode("utf-8").split(" ")
    result = TestResults(i, ans[2], ans[3])
    if not result:
        print("test result num {0} is : {1}".format(i, "Failed"))

