from subprocess import Popen, PIPE
from random import uniform
from random import randint

def GanerateTest(i):
    f = open("tests/test"+str(i)+".txt", "w+")
    f.write("epsilon = 1.0e-10\n")
    order = randint(1, 100)
    f.write("order = "+str(order)+"\n")
    for n in range(0,order+1):
        f.write("coeff "+str(n)+" = "+str(uniform(-10, 10))+" "+str(uniform(-10, 10))+"\n")
    f.write("initial = "+str(uniform(-10, 10))+" "+str(uniform(-10, 10))+"\n")
    f.close()




def eval_pol(test,real,img):
    resultReal = 0
    resultImg = 0
    realPower=1
    imgPower=0
    print(test)
    f = open(test, "r")
    next(f)
    order = f.readline()
    order = int((order.split(" "))[2])
    coeff = f.readline()
    coeff = coeff.split(" ")
    resultReal = float(coeff[3])
    resultImg = float(coeff[4])
    for i in range(1, order):
        tempReal = realPower
        realPower = (tempReal * real - realPower * img);
        imgPower = (tempReal*img + imgPower*real);
        coeff = f.readline()
        coeff = coeff.split(" ")
        coeffReal = float(coeff[2])
        coeffImg = float(coeff[3])
        tempReal = coeffReal
        coeffReal = (tempReal * realPower - coeffReal * imgPower)
        coeffImg = (tempReal * imgPower - coeffImg * realPower)
        resultReal += coeffReal
        resultImg += coeffImg
    return pow(pow(resultReal, 2)+pow(resultImg, 2), 0.5)




def TestResults(i,real,img):
    f = open("tests/test"+str(i)+".txt", "a")
    f.write("your result {0} {1} ".format(real,img))
    f.close()
    result = eval_pol("tests/test"+str(i)+".txt",ans[2],ans[3])
    if result < 1.0e-10:
        return True
    return False

for i in range(0, 10):
    GanerateTest(i)


for i in range(1, 2):
    process = Popen(["./root < tests/test"+str(0)+".txt"], stdout=PIPE, shell=True)
    (output, err) = process.communicate()
    exit_code = process.wait()
    ans = output.decode("utf-8").split(" ")
    result = TestResults(i, float(ans[2]), float(ans[3]))
    print("test result num {0} is : {1}".format(i, result))

