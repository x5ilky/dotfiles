stack<int> s; // indices
h[N+1] = INF;
s.push(N+1);

for(int i=N;i>=1;i--){
    while(h[s.top()] < h[i]) s.pop();
    nr[i] = s.top();
    s.push(i);
}
