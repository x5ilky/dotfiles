vector<int> adj[MAX_N];
bool seen[MAX_N];

void dfs(int node) {
    seen[node] = true;
    for(int a : adj[node]) {
        if (!seen[a]){
            dfs(a);
        }
    }
}
