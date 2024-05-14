import { PrismaClient } from "@prisma/client";
import express from "express"



const app =express()
const hostName= '127.0.0.1';
const port = 3000


const prisma = new PrismaClient({
    log:['query']
})

app.use(express.json());

// -----owner----//

app.post('/createOwner',async(req,res)=>{
    try {
      const createOwner =await prisma.owner.create({
        data:req.body
      })
      res.status(201).json(createOwner)
    } catch (error) {
       res.status(400).json({message:"error in creating"}) 
    }
})

app.get('/getOwner',async(req,res)=>{
    try {
      const getOwners = await prisma.owner.findMany({})  
      res.status(200).json(getOwners)
    } catch (error) {
    res.status(400).json({message:"error in getting owners"})    
    }
})

app.get('/getOwnerbyId/:id', async (req, res) => {
    try {
        const ownerId = parseInt(req.params.id);

        // Find the owner by ID
        const owner = await prisma.owner.findFirst({
            where: { id: ownerId },
            include: {
                Company: {
                    include: {
                        Employee: true,
                        project: true
                    }
                }
            }
        });

        // Check if owner is found
        if (!owner) {
            return res.status(404).json({ message: "Owner not found" });
        }

        res.status(200).json(owner);
    } catch (error) {
        console.error("Error finding the owner:", error);
        res.status(400).json({ message: "Error in finding the owner" });
    }
});

app.put("/updateOwner/:id",async(req,res)=>{
    try {
    const updateOwner=await prisma.owner.update({
        where:{
             id: +req.params.id     
        }   ,
        data:req.body         
    })    
    res.status(200).json(updateOwner)
    } catch (error) {
       res.status(400).json({message:"error in updating owner"}) 
    }
})

app.delete('/delowner/:id',async(req,res)=>{
    try {
    const delOwner= await prisma.owner.delete({
        where:{
            id:+req.params.id
        }
    }) 
    res.status(200).json(delOwner)
    } catch (error) {
      res.status(400).json({message:"error in deleting owner"})  
    }
})

// ----company---//

app.post('/owner/:id/company',async(req,res)=>{
    try {
       const owner=await prisma.owner.findUnique({
        where:{
            id:+req.params.id
        }
       })
       const data={
         ...req.body,
          owner_id: owner.id
       }
        const createCompany= await prisma.company.create({
           data:data
        })
        res.status(201).json(createCompany)
    } catch (error) {
      res.status(400).json({message:"error in creating companies"})  
    }
})

app.get('/owner/:id/company',async(req,res)=>{
    try {
        const company = await prisma.company.findMany({
            where:{
                owner_id:+req.params.id
            },
            include:{
                Employee:true,
                project:true
            }
        })
        res.status(200).json(company)
    } catch (error) {
        res.status(400).json({message:"error in fetching company"})
    }
})
app.get('/company/:id/employees',async(req,res)=>{
    try {
        const companyEmployee = await prisma.company.findFirst({
           where:{
            name:req.params.id
           } ,
           include:{
            Employee:true,
            project:true,
           
           }
        })
        res.status(200).json(companyEmployee)
    } catch (error) {
        res.status(400).json({message:"error in fetching company details"})
    }
})

app.get('/getCompanies',async(req,res)=>{
    try {
      const getCompanies=await prisma.company.findMany()
      res.status(200).json(getCompanies)
    } catch (error) {
      res.status(400).json({message:"error in fetching companies"})  
    }
})
app.put('/updateCompany/:id',async(req,res)=>{
    try {
        const updateCompany= await prisma.company.update({
            where:{
                id:+req.params.id
            },
            data:req.body
            
        })
        res.status(200).json(updateCompany)
    } catch (error) {
      res.status(400).json({message:"error in updating the company"})  
    }
})

app.delete('/deleteCompany/:id',async(req,res)=>{
    try {
        const deleteCompany=await prisma.company.delete({
            where:{
                id:+req.params.id
            }
        })
        res.status(200).json(deleteCompany)
    } catch (error) {
      res.status(400).json({message:"error in deleting the company"})  
    }
})

// ----employees---//

app.post('/company/:id/employees', async (req, res) => {
  try {
      const company = await prisma.company.findUnique({
          where: {
              id: +req.params.id
          }
      });

    
        const employee = await prisma.employee.create({
            data: {
                 ...req.body,
          companyId: company.id 
            }
        });

        res.status(201).json(employee);
    } catch (error) {
        console.error("Error creating employee:", error);
        res.status(400).json({ message: "Error in creating employees" });
    }
});


app.get('/company/:id/employees',async(req,res)=>{
    try {
       const company = await prisma.employee.findMany({
    where:{
        companyId:+req.params.id
    },
    include:{
        Profile:true
    }
       })
       res.status(200).json(company)
    } catch (error) {
        res.status(400).json({message:"error in finding the employees"})
    }
})

app.put('/updateEmployee/:id',async(req,res)=>{
    try {
        const updEmployee=await prisma.employee.update({
            where:{
                id:+req.params.id
            },
            data:req.body
            
        })
        res.status(200).json(updEmployee)
    } catch (error) {
        res.status(400).json({message:"error in updating the employees"})
    }
})

app.delete('/delEmployee/:id',async(req,res)=>{
    try {
      const delEmployee = await prisma.employee.delete({
        where:{
            id:+req.params.id
        }
      })  
      res.status(200).json(delEmployee)
    } catch (error) {
        res.status(400).json({message:"error in deleting the employee"})
    }
})

app.get('/employees',async(req,res)=>{
    try {
     const employees=await prisma.employee.findMany()
     res.status(200).json(employees)
    } catch (error) {
       res.status(400).json({message:"error in fetching all the employees"}) 
    }
})
// -----project----//

app.post('/company/:id/createProject', async (req, res) => {
    try {
        const companyId = +req.params.id;

        // Check if the company exists
        const existingCompany = await prisma.company.findUnique({
            where: {
                id: companyId
            }
        });

        if (!existingCompany) {
            return res.status(404).json({ message: "Company not found" });
        }

        const data = {
            ...req.body,
            companyId: existingCompany.id
        };

        const createProject = await prisma.project.create({
            data: data
        });

        res.status(201).json(createProject);
    } catch (error) {
        console.error("Error creating project:", error);
        res.status(400).json({ message: "Error in creating projects" });
    }
});

app.get('/company/:id/projects',async(req,res)=>{
    try {
      const company =await prisma.project.findMany({
        where: {
            companyId: +req.params.id
        }
      })
        res.status(200).json(company)
    } catch (error) {
        res.status(400).json({message:"error in fetching projects"})
    }
})

app.put('/company/project/:id',async(req,res)=>{
    try {
     const updProject =await prisma.project.update({
        where:{
            id:+req.params.id
        },
        data:req.body
     })  
     res.status(200).json(updProject) 
    } catch (error) {
       res.status(400).json({message:"error in updating the project"}) 
    }
})

app.delete('/delProject/:id',async(req,res)=>{
    try {
        const delProject = await prisma.project.delete({
            where:{
                id:+req.params.id
            }
        })
        res.status(200).json(delProject)
    } catch (error) {
        
    }
})

app.put('/employees/:id/project', async (req, res) => {
  try {
    const { projectId } = req.body;
    const employee = await prisma.employee.update({
      where: {
        id: +req.params.id
      },
      data: {
        projectId: projectId
      },
      include: {
        project: true
      }
    });

    res.status(200).json(employee);
  } catch (error) {
    console.error("Error updating employee project:", error);
    res.status(400).json({ message: "Error in updating employee project" });
  }
});

//----profile----//

app.post('/employee/:id/profile',async(req,res)=>{
    try {
        const profile =await prisma.profile.create({
            
            data:{
                employeeId:+req.params.id,
                ...req.body
            }
        })
        res.status(201).json(profile)
    } catch (error) {
        res.status(400).json({message:"error in creating profile"})
    }
})
app.get('/profiles',async(req,res)=>{
    try {
        const profiles =await prisma.profile.findMany()
        res.status(200).json(profiles)
    } catch (error) {
       res.status(400).json({message:"error in fetching profiles"}) 
    }
})
app.put('/updProfile/:id',async(req,res)=>{
    try {
    const updprofile =await prisma.profile.update({
        where:{id:+req.params.id},
        data:req.body
    })    
    res.status(200).json(updprofile)
    } catch (error) {
        res.status(400).json({message:"error in updating profile"})
    }
})
app.delete('/delProfile/:id',async(req,res)=>{
    try {
     const delProfile=await prisma.profile.delete({
        where:{
            id:+req.params.id
        }
     })   
     res.status(200).json(delProfile)
    } catch (error) {
    res.status(400).json({message:"error in deleting the profile"})    
    }
})

app.listen(port,hostName,()=>{
    console.log(`server is running on ${hostName}:${port}`)
})
