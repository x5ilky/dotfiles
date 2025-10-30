fill(dist+1, dist+N+1, -1);

// source is 1
queue<int> q;
q.push(1);
dist[1] = 0;

while(!q.empty()){
    int u = q.front();
    q.pop();
    for(int a : adj[u]){
        if (dist[a]==-1){
            dist[a] = dist[u] + 1;
            q.push(a);
        }
    }
}
