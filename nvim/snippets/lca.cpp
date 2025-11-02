#include <bits/stdc++.h>
using namespace std;
#define int long long
#define MAX_N 100010
#define MAX_LOGN 20

vector<int> adj[MAX_N];

int subTreeSize[MAX_N];
int preOrder[MAX_N];
int preOrderCount;
int anc[MAX_N][MAX_LOGN]; // set root's parent to itself

void dfs(int node) {
    preOrder[node] = ++preOrderCount;
    subTreeSize[node] = 1;
    for(auto a : adj[node]) if (!preOrder[a]){
        anc[a][0] = node;
        dfs(a);
        subTreeSize[node] += subTreeSize[a];
    }
}

// is u an ancestor of v
bool isAnc(int u, int v) {
    return preOrder[u] <= preOrder[v] && preOrder[v] < preOrder[u]+subTreeSize[u];
}


int lca(int u, int v) {
    if (isAnc(u,v)) return u;
    if (isAnc(v,u)) return v;
    int p = u;
    for(int k=MAX_LOGN-1;k>=0;k--){
        if (!isAnc(anc[p][k],v)){
            p = anc[p][k];
        }
    }
    return anc[p][0];
}

signed main(){
    cin.tie(0)->sync_with_stdio(0);
    int N,Q; cin >> N >> Q;
    for(int i=0;i<N-1;i++) {
        int x,y; cin >> x >> y;
        adj[x].push_back(y);
        adj[y].push_back(x);
    }
    anc[1][0] = 1;
    dfs(1);
    for(int k=1;k<MAX_LOGN;k++){
        for(int i=1;i<=N;i++){
            anc[i][k] = anc[anc[i][k-1]][k-1];
        }
    }
    while(Q--){
        int a,b; cin >> a >> b;
        cout << lca(a,b) << '\n';
    }

    return 0;
}
