clear,
close all,
clc

% Windows powershell open for python compile
% python -m py_compile File1.py File2.py File3.py ...

if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

pe = pyenv;
if pe.Status == 'NotLoaded'
    pyenv("ExecutionMode","OutOfProcess","Version","2.7");
end
py.list; % Call a Python function to load interpreter

signUser = "sefa";
message = "Message for RSA signing";

msg = strcat(signUser,message);
%  py.Signrsa.SignRSA(msg)

secret = 1234;
n = 4; t = 3;
% share = py.SSS.generate_shares(2,4,1234);

% s = py.Signrsa.yazdir();
shares = py.SecretSharing.deploy_shares("graylevel.bmp",3,4,1234);