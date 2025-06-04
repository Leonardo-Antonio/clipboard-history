import glob

def get_history():
    history_list = []
    for archivo in glob.glob("/tmp/history/*.log"):
        with open(archivo, "r") as f:
            history_list.append({
                "file": archivo,
                "content": f.read()
            })
    return history_list

        
        
