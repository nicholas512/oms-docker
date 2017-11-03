#!/bin/python2

def buildRpackage(pkg):
    import subprocess
    bashCommand = 'R CMD INSTALL -l Rlibs/build/ Rlibs/source/'
    bashCommand += pkg
    try:
        subprocess.check_output(bashCommand.split())
    except subprocess.CalledProcessError as error:
        print(error.output)
        exit(1)

def buildPkgName(pkgName,version):
    fullName = pkgName
    fullName += '_'
    fullName += version
    fullName += '.tar.gz'
    return fullName

class nodeObj:
    #Construction of Node with pkgName,version and children
    def _init_(self,pkgName=None,version=None,children=None,listPkgs=None):
        self.pkgName = pkgName
        self.version = version
        self.listPkgs = listPkgs
        if children is None:
            listPkgs.append(buildPkgName(self.pkgName,self.version))
            self.children = []
        else:
            self.children = children

#Construction of tree through recursion
class tree:
    def buildnode(self,ob,listPkgs):
        node= nodeObj()
        node.pkgName=ob['name']
        node.version=ob['version']
        node.children=[]
        for children in ob['dependencies']:
            node.children.append(self.buildnode(children,listPkgs))

        listPkgs.append(buildPkgName(node.pkgName,node.version))
        return node

#Building Json object from text file
class start:
    def run(self):
        import json

        file=open("Rlibs/package.json")
        data=json.load(file)
        listPkgs=[]
        builder = tree()
        builder.buildnode(data,listPkgs)
        for pkg in listPkgs[:-1]:
            buildRpackage(pkg)

buildPackages = start()
buildPackages.run()
