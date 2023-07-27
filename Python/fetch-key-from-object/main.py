import json

def get_object(json_string):
    try:
        return json.loads(json_string)
    except ValueError:
        raise ValueError("The object is invalid")
        

def get_element(object, key):
    current = object
    try:
        for k in key.split('/'):
            current = current[k]
        return current
    except KeyError:
        raise KeyError("The key does not exist in object")

if __name__ == "__main__":
    object = get_object(str(input()))
    key = str(input())
    print(get_element(object, key))