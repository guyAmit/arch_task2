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
    #eval code
    #code


def TestResults(i):
    f = open("tests/result"+str(i)+".txt","r")
    resultLine = f.readline()
    f.close()
    f = open("tests/test")
    ans = resultLine.split(" ")
    result=eval_pol("tests/test"+str(i)+".txt",ans[2],ans[3])
    if result<1.0e-10:
        return True
    return False

for i in range(0, 10):
    GanerateTest(i)


for i in range(0, 10):
    process = Popen(["./root < tests/test"+str(0)+".txt"], stdout=PIPE, shell=True)
    (output, err) = process.communicate()
    exit_code = process.wait()
    ans = output.decode("utf-8").split(" ")
    f = open("tests/result"+str(i)+".txt", "w+")
    f.write(ans[2]+" "+ans[3]+"\n")
    f.close()
    print(eval_pol(i))

