package quicapp;

import inet.applications.contract.IApp;
import inet.common.MessageDispatcher;

module QuicServerApp like IApp
{
    parameters:
        @display("i=block/app");
    gates:
        input socketIn;
        output socketOut;
    submodules:
        listener: <default("TcpServerListener")> like IApp {
            parameters:
                @display("p=100,100");
        }
        connection[0]: <default(listener.serverConnectionModuleType)> like IApp {
            parameters:
                @display("p=200,100,row,50");
        }
        ta: MessageDispatcher {
            parameters:
                @display("p=100,200");
        }
    connections:
        ta.out++ --> listener.socketIn;
        listener.socketOut --> ta.in++;
        ta.out++ --> { @display("m=s"); } --> socketOut;
        socketIn --> { @display("m=s"); } --> ta.in++;
}
