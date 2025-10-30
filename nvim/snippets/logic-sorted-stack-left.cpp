stack<int> s; // indices
h[N+1] = INF;
s.push(N+1);

for(int i=1;i<=N;i++){
    while(h[s.top()] < h[i]) s.pop();
    nl[i] = s.top();
    s.push(i);
}
