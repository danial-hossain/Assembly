#include<bits/stdc++.h>
using namespace std;

void showstack(stack <int> s){
    cout<<endl<<"The stack is : ";
    while(!s.empty()){
        cout<<"\t"<<s.top();
        s.pop();
    }
    cout<<"\n";
}

int main(void){
    stack <int> s;
    s.push(10);
    s.push(20);
    s.push(30);

    showstack(s);

    cout<<"\ns.size(): "<<s.size();
    cout<<"\ns.top(): "<<s.top();
    cout<<"\ns.pop(): ";
    s.pop();
    showstack(s);

    return 0;

}
